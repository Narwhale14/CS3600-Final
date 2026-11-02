-- WheelSteal: original dealership design + expanded vehicle attributes + customer accounts/saved cars.
-- Intended for a NEW EMPTY WheelSteal database. Does not drop existing tables.
-- If WheelSteal already exists, create a separate test database first.
CREATE DATABASE IF NOT EXISTS `WheelSteal` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `WheelSteal`;

CREATE TABLE `body_type` (
  `body_type_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `type_name` VARCHAR(50) NOT NULL UNIQUE,
  `parent_type_id` INT DEFAULT NULL,
  CONSTRAINT `fk_body_type_parent` FOREIGN KEY (`parent_type_id`) REFERENCES `body_type` (`body_type_id`)
) ENGINE=InnoDB;

CREATE TABLE `car` (
  `vin` CHAR(17) NOT NULL PRIMARY KEY,
  `make` VARCHAR(50) NOT NULL,
  `model` VARCHAR(50) NOT NULL,
  `year` SMALLINT UNSIGNED NOT NULL,
  `mileage` INT UNSIGNED NOT NULL,
  `listing_price` DECIMAL(10,2) NOT NULL,
  `status` ENUM('Available','Sold','Pending') NOT NULL DEFAULT 'Available',
  `city` VARCHAR(100) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `body_type_id` INT NOT NULL,
  `image_url` VARCHAR(500) DEFAULT NULL,
  `exterior_color` VARCHAR(50) NOT NULL,
  `fuel_type` ENUM('Diesel','Gas','Hybrid','EV','Other','Unknown') NOT NULL,
  `transmission` ENUM('Manual','Automatic','Other','Unknown') NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `description` TEXT,
  `owners` INT UNSIGNED NOT NULL,
  `papers` ENUM('Clean','Rebuilt','Salvage','Flood','Lemon','Junk','Other','Unknown') NOT NULL,
  `interior_color` VARCHAR(50) NOT NULL,
  `drivetrain` ENUM('FWD','RWD','AWD','4WD','Other','Unknown') NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT `fk_car_body_type` FOREIGN KEY (`body_type_id`) REFERENCES `body_type` (`body_type_id`),
  CONSTRAINT `chk_car_price` CHECK (`listing_price` >= 0)
) ENGINE=InnoDB;

CREATE TABLE `customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(20) DEFAULT NULL,
  `email` VARCHAR(100) DEFAULT NULL UNIQUE,
  `password_hash` VARCHAR(255) DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE `salesperson` (
  `salesperson_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(20) DEFAULT NULL,
  `email` VARCHAR(100) DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE `sale` (
  `sale_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `vin` CHAR(17) NOT NULL UNIQUE,
  `customer_id` INT NOT NULL,
  `salesperson_id` INT NOT NULL,
  `sale_price` DECIMAL(10,2) NOT NULL,
  `sale_date` DATE NOT NULL,
  CONSTRAINT `fk_sale_car` FOREIGN KEY (`vin`) REFERENCES `car` (`vin`),
  CONSTRAINT `fk_sale_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `fk_sale_salesperson` FOREIGN KEY (`salesperson_id`) REFERENCES `salesperson` (`salesperson_id`),
  CONSTRAINT `chk_sale_price` CHECK (`sale_price` >= 0)
) ENGINE=InnoDB;

-- Customer favorites: many-to-many relationship between customer and car.
CREATE TABLE `saved` (
  `customer_id` INT NOT NULL,
  `vin` CHAR(17) NOT NULL,
  `saved_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`, `vin`),
  CONSTRAINT `fk_saved_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_saved_car` FOREIGN KEY (`vin`) REFERENCES `car` (`vin`) ON DELETE CASCADE
) ENGINE=InnoDB;
