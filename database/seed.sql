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
-- Dumping data for table `listing`
--

LOCK TABLES `listing` WRITE;
/*!40000 ALTER TABLE `listing` DISABLE KEYS */;
INSERT INTO `listing` (`vin`,`seller_id`,`make`,`model`,`year`,`mileage`,`listing_price`,`status`,`city`,`state`,`body_type`,`image_url`,`exterior_color`,`interior_color`,`fuel_type`,`transmission`) VALUES ('D8FD4F95CD58111F1',2,'Honda','Civic',2022,28500,24500.00,'Available','Moscow','ID','Sedan','/images/civic.jpg','Blue','Black','Gas','Automatic'),('D8FD50686D58111F1',2,'Ford','Mustang',2020,36000,29995.00,'Available','Pullman','WA','Coupe','/images/mustang.jpg','Red','Black','Gas','Manual'),('D8FD50924D58111F1',2,'Volkswagen','Golf',2019,54000,17995.00,'Available','Spokane','WA','Hatchback','/images/golf.jpg','White','Gray','Gas','Automatic'),('D8FD50A3CD58111F1',2,'Toyota','RAV4',2022,31000,28995.00,'Available','Moscow','ID','Compact SUV','/images/rav4.jpg','Gray','Black','Hybrid','Automatic'),('D8FD50B36D58111F1',2,'Honda','CR-V',2021,46000,25995.00,'Available','Coeur d\'Alene','ID','Compact SUV','/images/crv.jpg','Black','Beige','Gas','Automatic'),('D8FD510EAD58111F1',2,'Chevrolet','Tahoe',2020,67000,38995.00,'Available','Spokane','WA','Full-Size SUV','/images/tahoe.jpg','Black','Black','Gas','Automatic'),('D8FD51202D58111F1',2,'Ford','F-150',2021,49000,34995.00,'Available','Lewiston','ID','Pickup','/images/f150.jpg','Blue','Gray','Gas','Automatic'),('D8FD5132ED58111F1',2,'Chevrolet','Silverado 2500HD',2019,81000,36500.00,'Available','Spokane','WA','Heavy-Duty Pickup','/images/silverado.jpg','Silver','Gray','Diesel','Automatic'),('D8FD51446D58111F1',2,'Toyota','Tacoma',2022,33000,32995.00,'Available','Pullman','WA','Pickup','/images/tacoma.jpg','Green','Black','Gas','Automatic'),('DEMO0000000000001',2,'Toyota','Camry',2021,42000,22995.00,'Sold','Moscow','ID','Sedan','/images/camry.jpg','Silver','Beige','Gas','Automatic');
/*!40000 ALTER TABLE `listing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sale`
--

LOCK TABLES `sale` WRITE;
/*!40000 ALTER TABLE `sale` DISABLE KEYS */;
INSERT INTO `sale` VALUES (1,'DEMO0000000000001',1,22500.00,'2026-10-31');
/*!40000 ALTER TABLE `sale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'John','Doe','208-111-2222','john.doe@test.com'),(2,'Eliot','Bicak','208-800-1122','eliot.bicak@test.com');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
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
