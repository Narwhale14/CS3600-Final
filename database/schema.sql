CREATE DATABASE IF NOT EXISTS `WheelSteal` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `WheelSteal`;

DROP TABLE IF EXISTS `sale`;
DROP TABLE IF EXISTS `listing`;
DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
);

CREATE TABLE `listing` (
  `vin` char(17) NOT NULL PRIMARY KEY,
  `title` varchar(100) NOT NULL,
  `description` text,
  `seller_id` int NOT NULL,
  `make` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `year` smallint unsigned NOT NULL,
  `mileage` int unsigned NOT NULL,
  `owners` int unsigned NOT NULL,
  `papers` enum('Clean','Rebuilt','Salvage','Flood','Lemon','Junk','Other','Unknown') NOT NULL,
  `listing_price` decimal(10,2) NOT NULL,
  `status` enum('Available','Sold', 'Pending') NOT NULL DEFAULT 'Available',
  `city` varchar(100) NOT NULL,
  `state` char(2) NOT NULL,
  `body_type` enum('Sedan','Hatchback','Coupe','Full-Size SUV','Mid-Size SUV','Compact SUV','Pickup','Heavy-Duty Pickup','Commercial Truck','Other','Unknown') NOT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `exterior_color` varchar(50) NOT NULL,
  `interior_color` varchar(50) NOT NULL,
  `fuel_type` enum('Diesel','Gas','Hybrid','EV','Other','Unknown') NOT NULL,
  `transmission` enum('Manual','Automatic','Other','Unknown') NOT NULL,
  `drivetrain` enum('FWD','RWD','AWD','4WD','Other','Unknown') NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `seller_id` (`seller_id`),
  CONSTRAINT `listing_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `listing_chk_1` CHECK ((`listing_price` >= 0))
);

CREATE TABLE `sale` (
  `sale_id` int NOT NULL AUTO_INCREMENT,
  `vin` char(17) NOT NULL,
  `buyer_id` int NOT NULL,
  `sale_price` decimal(10,2) NOT NULL,
  `sale_date` date NOT NULL,
  PRIMARY KEY (`sale_id`),
  UNIQUE KEY `vin` (`vin`),
  KEY `buyer_id` (`buyer_id`),
  CONSTRAINT `sale_ibfk_1` FOREIGN KEY (`vin`) REFERENCES `listing` (`vin`),
  CONSTRAINT `sale_ibfk_2` FOREIGN KEY (`buyer_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `sale_chk_1` CHECK ((`sale_price` >= 0))
);
