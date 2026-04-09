CREATE DATABASE  IF NOT EXISTS `smart_campus` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `smart_campus`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: smart_campus
-- ------------------------------------------------------
-- Server version	9.6.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'f1fc7e46-fbe9-11f0-b844-c85acf469f81:1-293';

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `AdminID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  `Role` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`AdminID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance` (
  `AttendanceID` int NOT NULL AUTO_INCREMENT,
  `Date` date DEFAULT NULL,
  `Status` varchar(10) DEFAULT NULL,
  `PRN` bigint DEFAULT NULL,
  `SubjectID` int DEFAULT NULL,
  `FacultyID` int DEFAULT NULL,
  PRIMARY KEY (`AttendanceID`),
  UNIQUE KEY `PRN` (`PRN`,`SubjectID`,`Date`),
  KEY `SubjectID` (`SubjectID`),
  KEY `FacultyID` (`FacultyID`),
  CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`PRN`) REFERENCES `student` (`PRN`),
  CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`SubjectID`) REFERENCES `subject` (`SubjectID`),
  CONSTRAINT `attendance_ibfk_3` FOREIGN KEY (`FacultyID`) REFERENCES `faculty` (`FacultyID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (1,'2026-03-01','Present',24070122078,1,1),(2,'2026-03-01','Absent',24070122081,1,1),(3,'2026-04-09','Present',24070122078,1,1),(4,'2026-04-09','Present',24070122061,1,1);
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `BookID` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(100) DEFAULT NULL,
  `Author` varchar(50) DEFAULT NULL,
  `Publisher` varchar(50) DEFAULT NULL,
  `TotalCopies` int DEFAULT NULL,
  `AvailableCopies` int DEFAULT NULL,
  PRIMARY KEY (`BookID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'DBMS Concepts','Korth','McGraw',5,0),(2,'Java Programming','Herbert Schildt','Oracle Press',4,3);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canteen_item`
--

DROP TABLE IF EXISTS `canteen_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `canteen_item` (
  `ItemID` int NOT NULL AUTO_INCREMENT,
  `ItemName` varchar(50) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Availability` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`ItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canteen_item`
--

LOCK TABLES `canteen_item` WRITE;
/*!40000 ALTER TABLE `canteen_item` DISABLE KEYS */;
INSERT INTO `canteen_item` VALUES (1,'Burger',50.00,1),(2,'Sandwich',40.00,1),(3,'Cold Coffee',60.00,1);
/*!40000 ALTER TABLE `canteen_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canteen_transaction`
--

DROP TABLE IF EXISTS `canteen_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `canteen_transaction` (
  `TransactionID` int NOT NULL AUTO_INCREMENT,
  `WalletID` int DEFAULT NULL,
  `ItemID` int DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `TotalAmount` decimal(10,2) DEFAULT NULL,
  `TransactionDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`TransactionID`),
  KEY `WalletID` (`WalletID`),
  KEY `ItemID` (`ItemID`),
  CONSTRAINT `canteen_transaction_ibfk_1` FOREIGN KEY (`WalletID`) REFERENCES `wallet` (`WalletID`),
  CONSTRAINT `canteen_transaction_ibfk_2` FOREIGN KEY (`ItemID`) REFERENCES `canteen_item` (`ItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canteen_transaction`
--

LOCK TABLES `canteen_transaction` WRITE;
/*!40000 ALTER TABLE `canteen_transaction` DISABLE KEYS */;
INSERT INTO `canteen_transaction` VALUES (1,1,1,2,100.00,'2026-04-06 15:23:37'),(2,1,2,1,40.00,'2026-04-06 15:42:19'),(3,2,1,1,390.00,'2026-04-09 18:23:18'),(4,2,1,1,300.00,'2026-04-09 18:23:26'),(5,2,1,1,300.00,'2026-04-09 18:23:38'),(6,1,1,1,340.00,'2026-04-09 18:28:23'),(7,1,3,1,300.00,'2026-04-09 18:28:30');
/*!40000 ALTER TABLE `canteen_transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deduct_wallet_balance` AFTER INSERT ON `canteen_transaction` FOR EACH ROW BEGIN
    UPDATE Wallet
    SET Balance = Balance - NEW.TotalAmount
    WHERE WalletID = NEW.WalletID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `DeptID` int NOT NULL AUTO_INCREMENT,
  `DeptName` varchar(50) NOT NULL,
  PRIMARY KEY (`DeptID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Computer Engineering'),(2,'IT'),(3,'ENTC');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty`
--

DROP TABLE IF EXISTS `faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty` (
  `FacultyID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `DeptID` int DEFAULT NULL,
  PRIMARY KEY (`FacultyID`),
  KEY `DeptID` (`DeptID`),
  CONSTRAINT `faculty_ibfk_1` FOREIGN KEY (`DeptID`) REFERENCES `department` (`DeptID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty`
--

LOCK TABLES `faculty` WRITE;
/*!40000 ALTER TABLE `faculty` DISABLE KEYS */;
INSERT INTO `faculty` VALUES (1,'Dr. Dipti','dipti@sit.edu','9999999999',1),(2,'Dr. Sharma','sharma@sit.edu','8888888888',1);
/*!40000 ALTER TABLE `faculty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `library_record`
--

DROP TABLE IF EXISTS `library_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `library_record` (
  `RecordID` int NOT NULL AUTO_INCREMENT,
  `PRN` bigint DEFAULT NULL,
  `BookID` int DEFAULT NULL,
  `IssueDate` date DEFAULT NULL,
  `ReturnDate` date DEFAULT NULL,
  `Fine` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`RecordID`),
  KEY `PRN` (`PRN`),
  KEY `BookID` (`BookID`),
  CONSTRAINT `library_record_ibfk_1` FOREIGN KEY (`PRN`) REFERENCES `student` (`PRN`),
  CONSTRAINT `library_record_ibfk_2` FOREIGN KEY (`BookID`) REFERENCES `book` (`BookID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `library_record`
--

LOCK TABLES `library_record` WRITE;
/*!40000 ALTER TABLE `library_record` DISABLE KEYS */;
INSERT INTO `library_record` VALUES (1,24070122078,1,'2026-03-01','2026-04-10',165.00),(2,24070122078,1,'2026-04-10','2026-04-10',0.00),(3,24070122061,2,'2026-04-10','2026-04-10',0.00),(4,24070122078,1,'2026-04-10','2026-04-10',0.00),(5,24070122061,1,'2026-04-10','2026-04-10',0.00),(6,24070122078,1,'2026-04-10','2026-04-10',0.00);
/*!40000 ALTER TABLE `library_record` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `reduce_book_count` AFTER INSERT ON `library_record` FOR EACH ROW BEGIN
    UPDATE Book
    SET AvailableCopies = AvailableCopies - 1
    WHERE BookID = NEW.BookID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `calculate_fine` BEFORE UPDATE ON `library_record` FOR EACH ROW BEGIN
    DECLARE days_late INT;

    IF NEW.ReturnDate IS NOT NULL THEN
        SET days_late = DATEDIFF(NEW.ReturnDate, NEW.IssueDate) - 7;

        IF days_late > 0 THEN
            SET NEW.Fine = days_late * 5;
        ELSE
            SET NEW.Fine = 0;
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rfid_card`
--

DROP TABLE IF EXISTS `rfid_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rfid_card` (
  `CardID` varchar(20) NOT NULL,
  `IssueDate` date DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL,
  `PRN` bigint DEFAULT NULL,
  PRIMARY KEY (`CardID`),
  UNIQUE KEY `PRN` (`PRN`),
  CONSTRAINT `rfid_card_ibfk_1` FOREIGN KEY (`PRN`) REFERENCES `student` (`PRN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rfid_card`
--

LOCK TABLES `rfid_card` WRITE;
/*!40000 ALTER TABLE `rfid_card` DISABLE KEYS */;
INSERT INTO `rfid_card` VALUES ('0003920706','2026-01-01','Active',24070122061),('0003930881','2026-01-01','Active',24070122081),('0040960552','2026-01-01','Active',24070122078);
/*!40000 ALTER TABLE `rfid_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `PRN` bigint NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `Branch` varchar(50) DEFAULT NULL,
  `Year` int DEFAULT NULL,
  `Batch` varchar(10) DEFAULT NULL,
  `DeptID` int DEFAULT NULL,
  `Division` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`PRN`),
  UNIQUE KEY `Email` (`Email`),
  KEY `DeptID` (`DeptID`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`DeptID`) REFERENCES `department` (`DeptID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (24070122061,'Chirag','chirag@gmail.com','9988776655','CSE',2,'2024-28',1,'B-1'),(24070122078,'Jalaj','jalaj@gmail.com','9876543210','CSE',2,'2024-28',1,'A-3'),(24070122081,'Jatin','jatin@gmail.com','9123456780','CSE',2,'2024-28',1,'A-3');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `SubjectID` int NOT NULL AUTO_INCREMENT,
  `SubjectName` varchar(50) DEFAULT NULL,
  `Semester` int DEFAULT NULL,
  `FacultyID` int DEFAULT NULL,
  PRIMARY KEY (`SubjectID`),
  KEY `FacultyID` (`FacultyID`),
  CONSTRAINT `subject_ibfk_1` FOREIGN KEY (`FacultyID`) REFERENCES `faculty` (`FacultyID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
INSERT INTO `subject` VALUES (1,'DBMS',4,1),(2,'Java',4,2);
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallet`
--

DROP TABLE IF EXISTS `wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallet` (
  `WalletID` int NOT NULL AUTO_INCREMENT,
  `Balance` decimal(10,2) DEFAULT '0.00',
  `PRN` bigint DEFAULT NULL,
  PRIMARY KEY (`WalletID`),
  UNIQUE KEY `PRN` (`PRN`),
  CONSTRAINT `wallet_ibfk_1` FOREIGN KEY (`PRN`) REFERENCES `student` (`PRN`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet`
--

LOCK TABLES `wallet` WRITE;
/*!40000 ALTER TABLE `wallet` DISABLE KEYS */;
INSERT INTO `wallet` VALUES (1,120.00,24070122078),(2,-690.00,24070122081);
/*!40000 ALTER TABLE `wallet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'smart_campus'
--
/*!50003 DROP FUNCTION IF EXISTS `GetBalance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `GetBalance`(studentPRN BIGINT) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    DECLARE bal DECIMAL(10,2);

    SELECT Balance INTO bal
    FROM Wallet
    WHERE PRN = studentPRN;

    RETURN bal;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `GetTotalFine` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `GetTotalFine`(studentPRN BIGINT) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    DECLARE totalFine DECIMAL(10,2);

    SELECT SUM(Fine) INTO totalFine
    FROM Library_Record
    WHERE PRN = studentPRN;

    RETURN IFNULL(totalFine, 0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddMoney` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddMoney`(
    IN studentPRN BIGINT,
    IN amount DECIMAL(10,2)
)
BEGIN
    UPDATE Wallet
    SET Balance = Balance + amount
    WHERE PRN = studentPRN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `IssueBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `IssueBook`(
    IN p_prn BIGINT,
    IN p_bookID INT
)
BEGIN
    DECLARE available INT;

    SELECT AvailableCopies INTO available
    FROM Book
    WHERE BookID = p_bookID;

    IF available > 0 THEN
        INSERT INTO Library_Record (PRN, BookID, IssueDate)
        VALUES (p_prn, p_bookID, CURDATE());
        UPDATE Book
        SET AvailableCopies = AvailableCopies - 1
        WHERE BookID = p_bookID;

    ELSE
        SELECT 'Book not available' AS Message;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MarkAttendance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MarkAttendance`(
    IN studentPRN BIGINT,
    IN subID INT,
    IN facID INT,
    IN status VARCHAR(10)
)
BEGIN
    INSERT INTO Attendance (Date, Status, PRN, SubjectID, FacultyID)
    VALUES (CURDATE(), status, studentPRN, subID, facID);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-10  0:45:38
