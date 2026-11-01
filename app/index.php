<?php

header('Content-Type: application/json');

$db = new PDO('mysql:host=127.0.0.1;dbname=WheelSteal;charset=utf8mb4', 'root', '');
$db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);

// GET /api/listings?vin=
if(isset($_GET['vin'])) {
    $stmt = $db->prepare('SELECT * FROM listing WHERE vin = ?');
    $stmt->execute([$_GET['vin']]);
    echo json_encode($stmt->fetch() ?: null);
    exit;
}

// GET /api/listings
echo json_encode($db->query('SELECT * FROM listing ORDER BY created_at DESC')->fetchAll());