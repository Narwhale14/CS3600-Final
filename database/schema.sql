-- WheelSteal: original dealership design + expanded vehicle attributes + customer accounts/saved cars.
-- Intended for a NEW EMPTY WheelSteal database. Does not drop existing tables.
-- If WheelSteal already exists, create a separate test database first.
CREATE DATABASE IF NOT EXISTS `WheelSteal` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `WheelSteal`;

CREATE TABLE `BodyType` (
  `BodyTypeID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `TypeName` VARCHAR(50) NOT NULL UNIQUE,
  `ParentTypeID` INT DEFAULT NULL,
  CONSTRAINT `fk_bodytype_parent` FOREIGN KEY (`ParentTypeID`) REFERENCES `BodyType` (`BodyTypeID`)
) ENGINE=InnoDB;

CREATE TABLE `Car` (
  `VIN` CHAR(17) NOT NULL PRIMARY KEY,
  `Make` VARCHAR(50) NOT NULL,
  `Model` VARCHAR(50) NOT NULL,
  `Year` SMALLINT UNSIGNED NOT NULL,
  `Mileage` INT UNSIGNED NOT NULL,
  `ListingPrice` DECIMAL(10,2) NOT NULL,
  `Status` ENUM('Available','Sold','Pending') NOT NULL DEFAULT 'Available',
  `City` VARCHAR(100) NOT NULL,
  `State` CHAR(2) NOT NULL,
  `BodyTypeID` INT NOT NULL,
  `ImageURL` VARCHAR(500) DEFAULT NULL,
  `Color` VARCHAR(50) NOT NULL,
  `FuelType` ENUM('Diesel','Gas','Hybrid','EV','Other','Unknown') NOT NULL,
  `Transmission` ENUM('Manual','Automatic','Other','Unknown') NOT NULL,
  `Title` VARCHAR(100) NOT NULL,
  `Description` TEXT,
  `Owners` INT UNSIGNED NOT NULL,
  `Papers` ENUM('Clean','Rebuilt','Salvage','Flood','Lemon','Junk','Other','Unknown') NOT NULL,
  `InteriorColor` VARCHAR(50) NOT NULL,
  `Drivetrain` ENUM('FWD','RWD','AWD','4WD','Other','Unknown') NOT NULL,
  `CreatedAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT `fk_car_bodytype` FOREIGN KEY (`BodyTypeID`) REFERENCES `BodyType` (`BodyTypeID`),
  CONSTRAINT `chk_car_price` CHECK (`ListingPrice` >= 0)
) ENGINE=InnoDB;

CREATE TABLE `Customer` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `FirstName` VARCHAR(50) NOT NULL,
  `LastName` VARCHAR(50) NOT NULL,
  `Phone` VARCHAR(20) DEFAULT NULL,
  `Email` VARCHAR(100) DEFAULT NULL UNIQUE,
  `PasswordHash` VARCHAR(255) DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE `Salesperson` (
  `SalespersonID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `FirstName` VARCHAR(50) NOT NULL,
  `LastName` VARCHAR(50) NOT NULL,
  `Phone` VARCHAR(20) DEFAULT NULL,
  `Email` VARCHAR(100) DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE `Sale` (
  `SaleID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `VIN` CHAR(17) NOT NULL UNIQUE,
  `CustomerID` INT NOT NULL,
  `SalespersonID` INT NOT NULL,
  `SalePrice` DECIMAL(10,2) NOT NULL,
  `SaleDate` DATE NOT NULL,
  CONSTRAINT `fk_sale_car` FOREIGN KEY (`VIN`) REFERENCES `Car` (`VIN`),
  CONSTRAINT `fk_sale_customer` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CustomerID`),
  CONSTRAINT `fk_sale_salesperson` FOREIGN KEY (`SalespersonID`) REFERENCES `Salesperson` (`SalespersonID`),
  CONSTRAINT `chk_sale_price` CHECK (`SalePrice` >= 0)
) ENGINE=InnoDB;

-- Customer favorites: many-to-many relationship between Customer and Car.
CREATE TABLE `Saved` (
  `CustomerID` INT NOT NULL,
  `VIN` CHAR(17) NOT NULL,
  `SavedDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`CustomerID`, `VIN`),
  CONSTRAINT `fk_saved_customer` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CustomerID`) ON DELETE CASCADE,
  CONSTRAINT `fk_saved_car` FOREIGN KEY (`VIN`) REFERENCES `Car` (`VIN`) ON DELETE CASCADE
) ENGINE=InnoDB;
