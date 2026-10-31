-- MySQL dump 10.13  Distrib 8.4.13, for macos26.6 (arm64)
--
-- Host: 127.0.0.1    Database: WheelSteal
-- ------------------------------------------------------
-- Server version	8.4.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `WheelSteal`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `WheelSteal` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `WheelSteal`;

--
-- Table structure for table `BodyType`
--

DROP TABLE IF EXISTS `BodyType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BodyType` (
  `BodyTypeID` int NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(50) NOT NULL,
  `ParentTypeID` int DEFAULT NULL,
  PRIMARY KEY (`BodyTypeID`),
  UNIQUE KEY `TypeName` (`TypeName`),
  KEY `ParentTypeID` (`ParentTypeID`),
  CONSTRAINT `bodytype_ibfk_1` FOREIGN KEY (`ParentTypeID`) REFERENCES `BodyType` (`BodyTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Car`
--

DROP TABLE IF EXISTS `Car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Car` (
  `VIN` char(17) NOT NULL,
  `Make` varchar(50) NOT NULL,
  `Model` varchar(50) NOT NULL,
  `Year` smallint unsigned NOT NULL,
  `Mileage` int unsigned NOT NULL,
  `ListingPrice` decimal(10,2) NOT NULL,
  `Status` enum('Available','Sold') NOT NULL DEFAULT 'Available',
  `City` varchar(100) NOT NULL,
  `State` char(2) NOT NULL,
  `BodyTypeID` int NOT NULL,
  `ImageURL` varchar(500) DEFAULT NULL,
  `Color` varchar(50) NOT NULL,
  `FuelType` enum('Diesel','Gas','Hybrid','EV') NOT NULL,
  `Transmission` enum('Manual','Automatic') NOT NULL,
  PRIMARY KEY (`VIN`),
  KEY `fk_cars_bodytype` (`BodyTypeID`),
  CONSTRAINT `fk_cars_bodytype` FOREIGN KEY (`BodyTypeID`) REFERENCES `BodyType` (`BodyTypeID`),
  CONSTRAINT `cars_chk_1` CHECK ((`ListingPrice` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `CustomerID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Sale`
--

DROP TABLE IF EXISTS `Sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sale` (
  `SaleID` int NOT NULL AUTO_INCREMENT,
  `VIN` char(17) NOT NULL,
  `CustomerID` int NOT NULL,
  `SalespersonID` int NOT NULL,
  `SalePrice` decimal(10,2) NOT NULL,
  `SaleDate` date NOT NULL,
  PRIMARY KEY (`SaleID`),
  UNIQUE KEY `VIN` (`VIN`),
  KEY `CustomerID` (`CustomerID`),
  KEY `SalespersonID` (`SalespersonID`),
  CONSTRAINT `sale_ibfk_1` FOREIGN KEY (`VIN`) REFERENCES `Car` (`VIN`),
  CONSTRAINT `sale_ibfk_2` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CustomerID`),
  CONSTRAINT `sale_ibfk_3` FOREIGN KEY (`SalespersonID`) REFERENCES `Salesperson` (`SalespersonID`),
  CONSTRAINT `sales_chk_1` CHECK ((`SalePrice` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Salesperson`
--

DROP TABLE IF EXISTS `Salesperson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Salesperson` (
  `SalespersonID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`SalespersonID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-31 16:26:00
