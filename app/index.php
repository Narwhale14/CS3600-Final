<?php
$db = require __DIR__ . '/db.php';

header('Content-Type: application/json');

// GET /api/listings?vin=
if(isset($_GET['vin'])) {
    $stmt = $db->prepare('SELECT * FROM listing WHERE vin = ?');
    $stmt->execute([$_GET['vin']]);
    echo json_encode($stmt->fetch() ?: null);
    exit;
}

// GET /api/listings
echo json_encode($db->query('SELECT * FROM listing ORDER BY created_at DESC')->fetchAll());