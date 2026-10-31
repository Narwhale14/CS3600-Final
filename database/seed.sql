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
-- Dumping data for table `BodyType`
--

LOCK TABLES `BodyType` WRITE;
/*!40000 ALTER TABLE `BodyType` DISABLE KEYS */;
INSERT INTO `BodyType` VALUES (1,'Body Type',NULL),(2,'Car',1),(3,'SUV',1),(4,'Truck',1),(5,'Sedan',2),(6,'Hatchback',2),(7,'Coupe',2),(8,'Full-Size SUV',3),(9,'Mid-Size SUV',3),(10,'Compact SUV',3),(11,'Pickup',4),(12,'Heavy-Duty Pickup',4),(13,'Commercial Truck',4);
/*!40000 ALTER TABLE `BodyType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Car`
--

LOCK TABLES `Car` WRITE;
/*!40000 ALTER TABLE `Car` DISABLE KEYS */;
INSERT INTO `Car` VALUES ('D8FD4F95CD58111F1','Honda','Civic',2022,28500,24500.00,'Available','Moscow','ID',5,'/images/civic.jpg','Blue','Gas','Automatic'),('D8FD50686D58111F1','Ford','Mustang',2020,36000,29995.00,'Available','Pullman','WA',7,'/images/mustang.jpg','Red','Gas','Manual'),('D8FD50924D58111F1','Volkswagen','Golf',2019,54000,17995.00,'Available','Spokane','WA',6,'/images/golf.jpg','White','Gas','Automatic'),('D8FD50A3CD58111F1','Toyota','RAV4',2022,31000,28995.00,'Available','Moscow','ID',10,'/images/rav4.jpg','Gray','Hybrid','Automatic'),('D8FD50B36D58111F1','Honda','CR-V',2021,46000,25995.00,'Available','Coeur d\'Alene','ID',10,'/images/crv.jpg','Black','Gas','Automatic'),('D8FD510EAD58111F1','Chevrolet','Tahoe',2020,67000,38995.00,'Available','Spokane','WA',8,'/images/tahoe.jpg','Black','Gas','Automatic'),('D8FD51202D58111F1','Ford','F-150',2021,49000,34995.00,'Available','Lewiston','ID',11,'/images/f150.jpg','Blue','Gas','Automatic'),('D8FD5132ED58111F1','Chevrolet','Silverado 2500HD',2019,81000,36500.00,'Available','Spokane','WA',12,'/images/silverado.jpg','Silver','Diesel','Automatic'),('D8FD51446D58111F1','Toyota','Tacoma',2022,33000,32995.00,'Available','Pullman','WA',11,'/images/tacoma.jpg','Green','Gas','Automatic'),('DEMO0000000000001','Toyota','Camry',2021,42000,22995.00,'Sold','Moscow','ID',5,'/images/camry.jpg','Silver','Gas','Automatic');
/*!40000 ALTER TABLE `Car` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES (1,'John','Doe','208-111-2222','john.doe@test.com');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Sale`
--

LOCK TABLES `Sale` WRITE;
/*!40000 ALTER TABLE `Sale` DISABLE KEYS */;
INSERT INTO `Sale` VALUES (1,'DEMO0000000000001',1,1,22500.00,'2026-10-31');
/*!40000 ALTER TABLE `Sale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Salesperson`
--

LOCK TABLES `Salesperson` WRITE;
/*!40000 ALTER TABLE `Salesperson` DISABLE KEYS */;
INSERT INTO `Salesperson` VALUES (1,'Eliot','Bicak','208-800-1122','eliot.bicak@test.com');
/*!40000 ALTER TABLE `Salesperson` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-31 16:22:14
