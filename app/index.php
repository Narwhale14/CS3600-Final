<?php

$db = require __DIR__ . '/db.php';

header('Content-Type: application/json');

// body_type is joined in by name since car only stores its id
$select = '
    SELECT c.*, b.type_name AS body_type
    FROM car c
    JOIN body_type b
      ON b.body_type_id = c.body_type_id
';

// GET /api/cars?vin=
if (isset($_GET['vin'])) {
    $stmt = $db->prepare("$select WHERE c.vin = ?");
    $stmt->execute([$_GET['vin']]);

    echo json_encode($stmt->fetch() ?: null);
    exit;
}

// GET /api/cars
$where = [];
$params = [];

$textFilters = [
    'make' => 'c.make',
    'model' => 'c.model',
    'city' => 'c.city',
    'exteriorColor' => 'c.exterior_color',
    'interiorColor' => 'c.interior_color'
];

foreach ($textFilters as $key => $column) {
    if (
        isset($_GET[$key]) &&
        is_string($_GET[$key]) &&
        trim($_GET[$key]) !== ''
    ) {
        $where[] = "$column LIKE :$key";
        $params[$key] = '%' . trim($_GET[$key]) . '%';
    }
}

if (
    isset($_GET['state']) &&
    is_string($_GET['state']) &&
    trim($_GET['state']) !== ''
) {
    $where[] = 'c.state = :state';
    $params['state'] = strtoupper(trim($_GET['state']));
}

$dropdownFilters = [
    'fuelType' => 'c.fuel_type',
    'transmission' => 'c.transmission',
    'drivetrain' => 'c.drivetrain',
    'status' => 'c.status',
    'papers' => 'c.papers'
];

foreach ($dropdownFilters as $key => $column) {
    if (
        isset($_GET[$key]) &&
        is_string($_GET[$key]) &&
        $_GET[$key] !== ''
    ) {
        $where[] = "$column = :$key";
        $params[$key] = $_GET[$key];
    }
}

$numberFilters = [
    'minPrice' => ['c.listing_price', '>='],
    'maxPrice' => ['c.listing_price', '<='],
    'minYear' => ['c.year', '>='],
    'maxYear' => ['c.year', '<='],
    'maxMileage' => ['c.mileage', '<='],
    'maxOwners' => ['c.owners', '<=']
];

foreach ($numberFilters as $key => [$column, $operator]) {
    if (
        isset($_GET[$key]) &&
        is_scalar($_GET[$key]) &&
        is_numeric($_GET[$key]) &&
        (float) $_GET[$key] >= 0
    ) {
        $where[] = "$column $operator :$key";
        $params[$key] = $_GET[$key];
    }
}

function searchCars(
    PDO $db,
    string $select,
    array $where,
    array $params,
    ?array $typeIds = null
): array {
    $conditions = $where;
    $bindings = $params;

    if ($typeIds !== null) {
        if (empty($typeIds)) {
            return [];
        }

        $placeholders = [];

        foreach (array_values($typeIds) as $i => $id) {
            $key = "bodyId$i";
            $placeholders[] = ":$key";
            $bindings[$key] = $id;
        }

        $conditions[] = 'c.body_type_id IN (' .
            implode(', ', $placeholders) . ')';
    }

    $sql = $select;

    if (!empty($conditions)) {
        $sql .= ' WHERE ' . implode(' AND ', $conditions);
    }

    $sql .= ' ORDER BY c.created_at DESC';

    $stmt = $db->prepare($sql);
    $stmt->execute($bindings);

    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function respond(
    array $cars,
    ?array $relaxation = null
): void {
    echo json_encode([
        'cars' => $cars,
        'relaxation' => $relaxation
    ]);

    exit;
}

function shownTypes(array $cars): array {
    return array_values(array_unique(
        array_column($cars, 'body_type')
    ));
}

$bodyType = (
    isset($_GET['bodyType']) &&
    is_string($_GET['bodyType'])
)
    ? trim($_GET['bodyType'])
    : '';

if ($bodyType === '') {
    $cars = searchCars($db, $select, $where, $params);
    respond($cars);
}

$stmt = $db->prepare('
    SELECT body_type_id, parent_type_id
    FROM body_type
    WHERE type_name = :name
');

$stmt->execute(['name' => $bodyType]);
$selected = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$selected) {
    respond([]);
}

$selectedId = (int) $selected['body_type_id'];
$parentId = $selected['parent_type_id'];

// Exact body type
$cars = searchCars(
    $db,
    $select,
    $where,
    $params,
    [$selectedId]
);

if (!empty($cars)) {
    respond($cars);
}

// Sibling body types
$siblingIds = [];

if ($parentId !== null) {
    $stmt = $db->prepare('
        SELECT body_type_id
        FROM body_type
        WHERE parent_type_id = :parent
          AND body_type_id <> :selected
    ');

    $stmt->execute([
        'parent' => $parentId,
        'selected' => $selectedId
    ]);

    $siblingIds = array_map(
        'intval',
        $stmt->fetchAll(PDO::FETCH_COLUMN)
    );
}

if (!empty($siblingIds)) {
    $cars = searchCars(
        $db,
        $select,
        $where,
        $params,
        $siblingIds
    );

    if (!empty($cars)) {
        respond($cars, [
            'requested' => $bodyType,
            'level' => 'siblings',
            'shownTypes' => shownTypes($cars)
        ]);
    }
}

// Other body types
$stmt = $db->query('
    SELECT b.body_type_id
    FROM body_type b
    WHERE NOT EXISTS (
        SELECT 1
        FROM body_type child
        WHERE child.parent_type_id = b.body_type_id
    )
');

$leafIds = array_map(
    'intval',
    $stmt->fetchAll(PDO::FETCH_COLUMN)
);

$excludedIds = array_merge(
    [$selectedId],
    $siblingIds
);

$otherIds = array_values(
    array_diff($leafIds, $excludedIds)
);

$cars = searchCars(
    $db,
    $select,
    $where,
    $params,
    $otherIds
);

if (!empty($cars)) {
    respond($cars, [
        'requested' => $bodyType,
        'level' => 'root',
        'shownTypes' => shownTypes($cars)
    ]);
}

respond([]);
