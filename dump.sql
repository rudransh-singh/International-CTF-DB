-- MySQL dump 10.13  Distrib 8.0.26, for Linux (x86_64)
--
-- Host: localhost    Database: KuRuNu
-- ------------------------------------------------------
-- Server version	8.0.26-0ubuntu0.21.04.3

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
-- Table structure for table `CONTEST`
--

DROP TABLE IF EXISTS `CONTEST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CONTEST` (
  `Contest_ID` int NOT NULL,
  `Start_Date` datetime NOT NULL,
  `Duration` int NOT NULL,
  `Contest_Rating` varchar(25) NOT NULL,
  PRIMARY KEY (`Contest_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONTEST`
--

LOCK TABLES `CONTEST` WRITE;
/*!40000 ALTER TABLE `CONTEST` DISABLE KEYS */;
INSERT INTO `CONTEST` VALUES (1,'2020-05-01 18:00:00',3,'Difficult'),(2,'2020-09-02 15:00:00',4,'Extremely hard'),(3,'2020-12-06 16:00:00',2,'very easy');
/*!40000 ALTER TABLE `CONTEST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CONTESTANT`
--

DROP TABLE IF EXISTS `CONTESTANT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CONTESTANT` (
  `Hacker_ID` int NOT NULL,
  `College_Year` int NOT NULL,
  `Team_No` int NOT NULL,
  KEY `Hacker_ID` (`Hacker_ID`),
  CONSTRAINT `CONTESTANT_ibfk_1` FOREIGN KEY (`Hacker_ID`) REFERENCES `HACKER` (`Hacker_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONTESTANT`
--

LOCK TABLES `CONTESTANT` WRITE;
/*!40000 ALTER TABLE `CONTESTANT` DISABLE KEYS */;
INSERT INTO `CONTESTANT` VALUES (1,3,1),(2,3,1),(3,3,1),(4,2,2),(5,2,2),(6,2,2),(7,1,3),(8,1,3),(9,1,3);
/*!40000 ALTER TABLE `CONTESTANT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HACKER`
--

DROP TABLE IF EXISTS `HACKER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `HACKER` (
  `Hacker_ID` int NOT NULL,
  `First_Name` varchar(50) NOT NULL,
  `Last_Name` varchar(50) NOT NULL,
  `Age` int NOT NULL,
  `Email_ID` varchar(50) NOT NULL,
  `is_setter` int NOT NULL,
  PRIMARY KEY (`Hacker_ID`),
  UNIQUE KEY `Email_ID` (`Email_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HACKER`
--

LOCK TABLES `HACKER` WRITE;
/*!40000 ALTER TABLE `HACKER` DISABLE KEYS */;
INSERT INTO `HACKER` VALUES (1,'Kushagra','Kharbanda',20,'contestant1@gmail.com',0),(2,'Rudransh','Singh',20,'contestant2@gmail.com',0),(3,'Nukit','Tailor',20,'contestant3@gmail.com',0),(4,'Pramod','Rao',19,'contestant4@gmail.com',0),(5,'Kishore','Kumar',18,'contestant5@gmail.com',0),(6,'Vidit','Jain',19,'contestant6@gmail.com',0),(7,'Abhijnan','Vegi',19,'contestant7@gmail.com',0),(8,'Vamshi','Krishna',19,'contestant8@gmail.com',0),(9,'Shavak','Kansal',19,'contestant9@gmail.com',0),(10,'PK','Reddy',40,'problem_setter1@gmail.com',1),(11,'Prabhakar','Bhima',40,'problem_setter2@gmail.com',1),(12,'BG','Manjunath',40,'problem_setter3@gmail.com',1);
/*!40000 ALTER TABLE `HACKER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PARTICIPATES`
--

DROP TABLE IF EXISTS `PARTICIPATES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PARTICIPATES` (
  `Team_No` int NOT NULL,
  `Contest_ID` int NOT NULL,
  PRIMARY KEY (`Team_No`,`Contest_ID`),
  KEY `Contest_ID` (`Contest_ID`),
  CONSTRAINT `PARTICIPATES_ibfk_1` FOREIGN KEY (`Team_No`) REFERENCES `TEAM` (`Team_No`),
  CONSTRAINT `PARTICIPATES_ibfk_2` FOREIGN KEY (`Contest_ID`) REFERENCES `CONTEST` (`Contest_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PARTICIPATES`
--

LOCK TABLES `PARTICIPATES` WRITE;
/*!40000 ALTER TABLE `PARTICIPATES` DISABLE KEYS */;
INSERT INTO `PARTICIPATES` VALUES (1,1),(3,1),(1,2),(3,2),(2,3),(3,3);
/*!40000 ALTER TABLE `PARTICIPATES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROBLEM`
--

DROP TABLE IF EXISTS `PROBLEM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROBLEM` (
  `Prob_Number` int NOT NULL,
  `Contest_ID` int NOT NULL,
  `Hacker_ID` int NOT NULL,
  `Output_Format` varchar(100) NOT NULL,
  `P_Statement` varchar(500) NOT NULL,
  `Max_Points` int NOT NULL,
  `Rating` int NOT NULL,
  PRIMARY KEY (`Prob_Number`,`Contest_ID`),
  KEY `Contest_ID` (`Contest_ID`),
  KEY `Hacker_ID` (`Hacker_ID`),
  CONSTRAINT `PROBLEM_ibfk_1` FOREIGN KEY (`Contest_ID`) REFERENCES `CONTEST` (`Contest_ID`),
  CONSTRAINT `PROBLEM_ibfk_2` FOREIGN KEY (`Hacker_ID`) REFERENCES `PROBLEM_SETTER` (`Hacker_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROBLEM`
--

LOCK TABLES `PROBLEM` WRITE;
/*!40000 ALTER TABLE `PROBLEM` DISABLE KEYS */;
INSERT INTO `PROBLEM` VALUES (1,1,10,'oformat1','Problem statement for problem 1 contest 1',500,3),(1,2,10,'oformat2','Problem statement for problem 1 contest 2',700,3),(1,3,11,'oformat3','Problem statement for problem 1 contest 3',900,1),(2,1,12,'oformat4','Problem statement for problem 2 contest 1',1000,3),(2,2,11,'oformat5','Problem statement for problem 2 contest 2',400,2),(3,1,10,'oformat6','Problem statement for problem 3 contest 1',300,4),(3,2,11,'oformat7','Problem statement for problem 3 contest 2',500,5);
/*!40000 ALTER TABLE `PROBLEM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROBLEM_HINTS`
--

DROP TABLE IF EXISTS `PROBLEM_HINTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROBLEM_HINTS` (
  `Contest_ID` int NOT NULL,
  `Prob_Number` int NOT NULL,
  `Hints` varchar(500) NOT NULL,
  PRIMARY KEY (`Contest_ID`,`Prob_Number`,`Hints`),
  KEY `Prob_Number` (`Prob_Number`),
  CONSTRAINT `PROBLEM_HINTS_ibfk_1` FOREIGN KEY (`Prob_Number`) REFERENCES `PROBLEM` (`Prob_Number`),
  CONSTRAINT `PROBLEM_HINTS_ibfk_2` FOREIGN KEY (`Contest_ID`) REFERENCES `PROBLEM` (`Contest_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROBLEM_HINTS`
--

LOCK TABLES `PROBLEM_HINTS` WRITE;
/*!40000 ALTER TABLE `PROBLEM_HINTS` DISABLE KEYS */;
INSERT INTO `PROBLEM_HINTS` VALUES (1,1,'hint1'),(2,1,'hint2'),(3,1,'hint3'),(1,2,'hint4'),(2,2,'hint5'),(1,3,'hint6'),(2,3,'hint7');
/*!40000 ALTER TABLE `PROBLEM_HINTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROBLEM_SETTER`
--

DROP TABLE IF EXISTS `PROBLEM_SETTER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROBLEM_SETTER` (
  `Hacker_ID` int NOT NULL,
  `Experience` int NOT NULL,
  `No_Of_Problems` int NOT NULL,
  KEY `Hacker_ID` (`Hacker_ID`),
  CONSTRAINT `PROBLEM_SETTER_ibfk_1` FOREIGN KEY (`Hacker_ID`) REFERENCES `HACKER` (`Hacker_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROBLEM_SETTER`
--

LOCK TABLES `PROBLEM_SETTER` WRITE;
/*!40000 ALTER TABLE `PROBLEM_SETTER` DISABLE KEYS */;
INSERT INTO `PROBLEM_SETTER` VALUES (10,20,100),(11,15,75),(12,10,50);
/*!40000 ALTER TABLE `PROBLEM_SETTER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROBLEM_TAGS`
--

DROP TABLE IF EXISTS `PROBLEM_TAGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROBLEM_TAGS` (
  `Contest_ID` int NOT NULL,
  `Prob_Number` int NOT NULL,
  `Tags` varchar(20) NOT NULL,
  PRIMARY KEY (`Contest_ID`,`Prob_Number`,`Tags`),
  KEY `Prob_Number` (`Prob_Number`),
  CONSTRAINT `PROBLEM_TAGS_ibfk_1` FOREIGN KEY (`Prob_Number`) REFERENCES `PROBLEM` (`Prob_Number`),
  CONSTRAINT `PROBLEM_TAGS_ibfk_2` FOREIGN KEY (`Contest_ID`) REFERENCES `PROBLEM` (`Contest_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROBLEM_TAGS`
--

LOCK TABLES `PROBLEM_TAGS` WRITE;
/*!40000 ALTER TABLE `PROBLEM_TAGS` DISABLE KEYS */;
INSERT INTO `PROBLEM_TAGS` VALUES (1,1,'tag1'),(2,1,'tag2'),(3,1,'tag3'),(1,2,'tag4'),(2,2,'tag5'),(1,3,'tag6'),(2,3,'tag7');
/*!40000 ALTER TABLE `PROBLEM_TAGS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESULT`
--

DROP TABLE IF EXISTS `RESULT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESULT` (
  `Answer_Given` varchar(100) NOT NULL,
  `Verdict` varchar(10) NOT NULL,
  `Sub_ID` int NOT NULL,
  `Prob_Number` int NOT NULL,
  `Team_No` int NOT NULL,
  `Points` int NOT NULL,
  PRIMARY KEY (`Answer_Given`,`Verdict`,`Sub_ID`,`Prob_Number`,`Team_No`),
  KEY `Sub_ID` (`Sub_ID`),
  KEY `Prob_Number` (`Prob_Number`),
  KEY `Team_No` (`Team_No`),
  CONSTRAINT `RESULT_ibfk_1` FOREIGN KEY (`Sub_ID`) REFERENCES `SUBMISSION` (`Sub_ID`),
  CONSTRAINT `RESULT_ibfk_2` FOREIGN KEY (`Prob_Number`) REFERENCES `PROBLEM` (`Prob_Number`),
  CONSTRAINT `RESULT_ibfk_3` FOREIGN KEY (`Team_No`) REFERENCES `TEAM` (`Team_No`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESULT`
--

LOCK TABLES `RESULT` WRITE;
/*!40000 ALTER TABLE `RESULT` DISABLE KEYS */;
INSERT INTO `RESULT` VALUES ('4udhCS3SXPH2sQLJTbsZ','CORRECT',2,1,2,700),('A9SyBDVZLCOK69RaPvd3','WRONG',11,1,1,0),('Eqol7FPIQTkVkj1IkC8N','WRONG',13,3,3,0),('F89C1L5WyeNt0fWvsHIV','WRONG',14,1,1,0),('FFkahTk6DsM1ROLWKGoS','CORRECT',7,3,3,300),('FnCimfpmuYfVS9aEj9ov','WRONG',16,2,1,0),('I9ApDL8C8R6OYlZjPMKm','CORRECT',9,2,1,400),('jmHWkrLUG79d7KMPvBi6','CORRECT',6,3,1,500),('KdMQYBP3WqEvSHQWqQTR','WRONG',15,3,1,0),('l1aNYwfr60ghFf42zrb9','CORRECT',1,1,1,500),('mEaoEulFqnnTlpxFZMAU','CORRECT',5,2,3,400),('MPDojFYpJuVCc8lZLgQM','WRONG',12,2,2,0),('o21CTHsdKDTwyk12FhBJ','CORRECT',10,3,1,500),('oIJ3cxcnOTThcZ2Nx3fa','CORRECT',3,1,3,900),('SrFYh4DGOcfRsmK2AEHY','CORRECT',4,2,1,1000),('zB3umKNKVSnUYdLDZP09','CORRECT',8,1,1,900);
/*!40000 ALTER TABLE `RESULT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SUBMISSION`
--

DROP TABLE IF EXISTS `SUBMISSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SUBMISSION` (
  `Sub_ID` int NOT NULL,
  `Sub_Time` datetime NOT NULL,
  PRIMARY KEY (`Sub_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SUBMISSION`
--

LOCK TABLES `SUBMISSION` WRITE;
/*!40000 ALTER TABLE `SUBMISSION` DISABLE KEYS */;
INSERT INTO `SUBMISSION` VALUES (1,'2020-05-01 18:12:00'),(2,'2020-05-01 18:15:00'),(3,'2020-05-01 18:16:00'),(4,'2020-05-01 18:17:00'),(5,'2020-05-01 18:25:00'),(6,'2020-05-01 18:20:00'),(7,'2020-05-01 19:40:00'),(8,'2020-09-02 15:21:00'),(9,'2020-09-02 15:25:00'),(10,'2020-09-02 15:40:00'),(11,'2020-09-02 16:10:00'),(12,'2020-09-02 16:45:00'),(13,'2020-12-06 16:52:00'),(14,'2020-12-06 17:30:00'),(15,'2020-12-06 17:45:00'),(16,'2020-12-06 17:56:00');
/*!40000 ALTER TABLE `SUBMISSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SUBMITS`
--

DROP TABLE IF EXISTS `SUBMITS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SUBMITS` (
  `Sub_ID` int NOT NULL,
  `Team_No` int NOT NULL,
  `Contest_ID` int NOT NULL,
  `Answer_Given` varchar(100) NOT NULL,
  `Verdict` varchar(10) NOT NULL,
  `Prob_Number` int NOT NULL,
  PRIMARY KEY (`Sub_ID`,`Team_No`,`Contest_ID`,`Answer_Given`,`Verdict`,`Prob_Number`),
  KEY `Team_No` (`Team_No`),
  KEY `Contest_ID` (`Contest_ID`),
  KEY `Prob_Number` (`Prob_Number`),
  CONSTRAINT `SUBMITS_ibfk_1` FOREIGN KEY (`Sub_ID`) REFERENCES `SUBMISSION` (`Sub_ID`),
  CONSTRAINT `SUBMITS_ibfk_2` FOREIGN KEY (`Team_No`) REFERENCES `TEAM` (`Team_No`),
  CONSTRAINT `SUBMITS_ibfk_3` FOREIGN KEY (`Contest_ID`) REFERENCES `CONTEST` (`Contest_ID`),
  CONSTRAINT `SUBMITS_ibfk_4` FOREIGN KEY (`Prob_Number`) REFERENCES `PROBLEM` (`Prob_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SUBMITS`
--

LOCK TABLES `SUBMITS` WRITE;
/*!40000 ALTER TABLE `SUBMITS` DISABLE KEYS */;
INSERT INTO `SUBMITS` VALUES (1,1,1,'l1aNYwfr60ghFf42zrb9','CORRECT',1),(4,1,1,'SrFYh4DGOcfRsmK2AEHY','CORRECT',2),(6,1,1,'jmHWkrLUG79d7KMPvBi6','CORRECT',3),(8,1,2,'zB3umKNKVSnUYdLDZP09','CORRECT',1),(9,1,2,'I9ApDL8C8R6OYlZjPMKm','CORRECT',2),(10,1,2,'o21CTHsdKDTwyk12FhBJ','CORRECT',3),(11,1,2,'A9SyBDVZLCOK69RaPvd3','WRONG',1),(14,1,3,'F89C1L5WyeNt0fWvsHIV','WRONG',1),(15,1,3,'KdMQYBP3WqEvSHQWqQTR','WRONG',3),(16,1,3,'FnCimfpmuYfVS9aEj9ov','WRONG',2),(2,2,1,'4udhCS3SXPH2sQLJTbsZ','CORRECT',1),(12,2,2,'MPDojFYpJuVCc8lZLgQM','WRONG',2),(3,3,1,'oIJ3cxcnOTThcZ2Nx3fa','CORRECT',1),(5,3,1,'mEaoEulFqnnTlpxFZMAU','CORRECT',2),(7,3,1,'FFkahTk6DsM1ROLWKGoS','CORRECT',3),(13,3,3,'Eqol7FPIQTkVkj1IkC8N','WRONG',3);
/*!40000 ALTER TABLE `SUBMITS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TEAM`
--

DROP TABLE IF EXISTS `TEAM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TEAM` (
  `Team_No` int NOT NULL,
  `Team_Name` varchar(100) NOT NULL,
  PRIMARY KEY (`Team_No`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TEAM`
--

LOCK TABLES `TEAM` WRITE;
/*!40000 ALTER TABLE `TEAM` DISABLE KEYS */;
INSERT INTO `TEAM` VALUES (1,'KuRuNu'),(2,'Fightfight'),(3,'vegijod');
/*!40000 ALTER TABLE `TEAM` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-26  6:15:59
