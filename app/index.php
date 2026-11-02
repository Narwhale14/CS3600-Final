<?php
$db = require __DIR__ . '/db.php';

header('Content-Type: application/json');

// body_type is joined in by name since car only stores its id
$select = 'SELECT c.*, b.type_name AS body_type FROM car c JOIN body_type b ON b.body_type_id = c.body_type_id';

// GET /api/cars?vin=
if(isset($_GET['vin'])) {
    $stmt = $db->prepare("$select WHERE c.vin = ?");
    $stmt->execute([$_GET['vin']]);
    echo json_encode($stmt->fetch() ?: null);
    exit;
}

// GET /api/cars
echo json_encode($db->query("$select ORDER BY c.created_at DESC")->fetchAll());