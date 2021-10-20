-- MySQL dump 10.13  Distrib 5.7.35, for Linux (x86_64)
--
-- Host: localhost    Database: KuRuNu
-- ------------------------------------------------------
-- Server version	5.7.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CONTEST` (
  `Contest_ID` int(11) NOT NULL,
  `Start_Date` datetime NOT NULL,
  `Duration` int(11) NOT NULL,
  `Contest_Rating` varchar(25) NOT NULL,
  PRIMARY KEY (`Contest_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONTEST`
--

LOCK TABLES `CONTEST` WRITE;
/*!40000 ALTER TABLE `CONTEST` DISABLE KEYS */;
/*!40000 ALTER TABLE `CONTEST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CONTESTANT`
--

DROP TABLE IF EXISTS `CONTESTANT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CONTESTANT` (
  `Hacker_ID` int(11) NOT NULL,
  `College_Year` int(11) NOT NULL,
  KEY `Hacker_ID` (`Hacker_ID`),
  CONSTRAINT `CONTESTANT_ibfk_1` FOREIGN KEY (`Hacker_ID`) REFERENCES `HACKER` (`Hacker_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONTESTANT`
--

LOCK TABLES `CONTESTANT` WRITE;
/*!40000 ALTER TABLE `CONTESTANT` DISABLE KEYS */;
/*!40000 ALTER TABLE `CONTESTANT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HACKER`
--

DROP TABLE IF EXISTS `HACKER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HACKER` (
  `Hacker_ID` int(11) NOT NULL,
  `First_Name` varchar(50) NOT NULL,
  `Last_Name` varchar(50) NOT NULL,
  `Age` int(11) NOT NULL,
  `Email_ID` varchar(50) NOT NULL,
  PRIMARY KEY (`Hacker_ID`),
  UNIQUE KEY `Email_ID` (`Email_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HACKER`
--

LOCK TABLES `HACKER` WRITE;
/*!40000 ALTER TABLE `HACKER` DISABLE KEYS */;
/*!40000 ALTER TABLE `HACKER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PARTICIPATES`
--

DROP TABLE IF EXISTS `PARTICIPATES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PARTICIPATES` (
  `Team_No` int(11) NOT NULL,
  `Contest_ID` int(11) NOT NULL,
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
/*!40000 ALTER TABLE `PARTICIPATES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROBLEM`
--

DROP TABLE IF EXISTS `PROBLEM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROBLEM` (
  `Prob_Number` int(11) NOT NULL,
  `Contest_ID` int(11) NOT NULL,
  `Hacker_ID` int(11) NOT NULL,
  `Output_Format` varchar(100) NOT NULL,
  `P_Statement` varchar(500) NOT NULL,
  `Max_Points` int(11) NOT NULL,
  `Rating` int(11) NOT NULL,
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
/*!40000 ALTER TABLE `PROBLEM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROBLEM_HINTS`
--

DROP TABLE IF EXISTS `PROBLEM_HINTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROBLEM_HINTS` (
  `Contest_ID` int(11) NOT NULL,
  `Prob_Number` int(11) NOT NULL,
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
/*!40000 ALTER TABLE `PROBLEM_HINTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROBLEM_SETTER`
--

DROP TABLE IF EXISTS `PROBLEM_SETTER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROBLEM_SETTER` (
  `Hacker_ID` int(11) NOT NULL,
  `Experience` int(11) NOT NULL,
  `No_Of_Problems` int(11) NOT NULL,
  KEY `Hacker_ID` (`Hacker_ID`),
  CONSTRAINT `PROBLEM_SETTER_ibfk_1` FOREIGN KEY (`Hacker_ID`) REFERENCES `HACKER` (`Hacker_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROBLEM_SETTER`
--

LOCK TABLES `PROBLEM_SETTER` WRITE;
/*!40000 ALTER TABLE `PROBLEM_SETTER` DISABLE KEYS */;
/*!40000 ALTER TABLE `PROBLEM_SETTER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROBLEM_TAGS`
--

DROP TABLE IF EXISTS `PROBLEM_TAGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROBLEM_TAGS` (
  `Contest_ID` int(11) NOT NULL,
  `Prob_Number` int(11) NOT NULL,
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
/*!40000 ALTER TABLE `PROBLEM_TAGS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESULT`
--

DROP TABLE IF EXISTS `RESULT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESULT` (
  `Answer_Given` varchar(100) NOT NULL,
  `Verdict` varchar(10) NOT NULL,
  `Sub_ID` int(11) NOT NULL,
  `Prob_Number` int(11) NOT NULL,
  `Team_No` int(11) NOT NULL,
  `Points` int(11) NOT NULL,
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
/*!40000 ALTER TABLE `RESULT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SUBMISSION`
--

DROP TABLE IF EXISTS `SUBMISSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SUBMISSION` (
  `Sub_ID` int(11) NOT NULL,
  `Sub_Time` datetime NOT NULL,
  PRIMARY KEY (`Sub_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SUBMISSION`
--

LOCK TABLES `SUBMISSION` WRITE;
/*!40000 ALTER TABLE `SUBMISSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `SUBMISSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SUBMITS`
--

DROP TABLE IF EXISTS `SUBMITS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SUBMITS` (
  `Sub_ID` int(11) NOT NULL,
  `Team_No` int(11) NOT NULL,
  `Contest_ID` int(11) NOT NULL,
  `Answer_Given` varchar(100) NOT NULL,
  `Verdict` varchar(10) NOT NULL,
  `Prob_Number` int(11) NOT NULL,
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
/*!40000 ALTER TABLE `SUBMITS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TEAM`
--

DROP TABLE IF EXISTS `TEAM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TEAM` (
  `Team_No` int(11) NOT NULL,
  `Team_Name` varchar(100) NOT NULL,
  PRIMARY KEY (`Team_No`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TEAM`
--

LOCK TABLES `TEAM` WRITE;
/*!40000 ALTER TABLE `TEAM` DISABLE KEYS */;
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

-- Dump completed on 2021-10-20 13:20:38
