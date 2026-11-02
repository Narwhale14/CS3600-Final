<?php
$db = require __DIR__ . '/db.php';

header('Content-Type: application/json');

// GET /api/cars?vin=
if(isset($_GET['vin'])) {
    $stmt = $db->prepare('SELECT * FROM Car WHERE VIN = ?');
    $stmt->execute([$_GET['vin']]);
    echo json_encode($stmt->fetch() ?: null);
    exit;
}

// GET /api/cars
echo json_encode($db->query('SELECT * FROM Car ORDER BY CreatedAt DESC')->fetchAll());