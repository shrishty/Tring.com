-- MySQL dump 10.13  Distrib 5.5.34, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	5.5.34-0ubuntu0.13.04.1

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `ADD_ID` int(11) NOT NULL,
  `LINE1` varchar(45) DEFAULT NULL,
  `LINE2` varchar(45) DEFAULT NULL,
  `LINE3` varchar(45) DEFAULT NULL,
  `STREET` varchar(45) DEFAULT NULL,
  `CITY` varchar(45) NOT NULL,
  `STATE` varchar(45) NOT NULL,
  `ZIPCODE` varchar(45) NOT NULL,
  `COUNTRY` varchar(45) NOT NULL,
  `OTHER` varchar(45) DEFAULT NULL,
  `ADDRESS_TYPE_ID` int(11) NOT NULL,
  `user_UID` int(11) NOT NULL,
  PRIMARY KEY (`ADD_ID`),
  KEY `fk_address_address_type1` (`ADDRESS_TYPE_ID`),
  KEY `fk_address_user1` (`user_UID`),
  CONSTRAINT `fk_address_address_type1` FOREIGN KEY (`ADDRESS_TYPE_ID`) REFERENCES `address_type` (`ADDRESS_TYPE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_user1` FOREIGN KEY (`user_UID`) REFERENCES `user` (`UID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'Room no 329','Ladies Hostel','National institute of Technlogy Calicut','Near Kattangal','Calicut','Kerala','673601','India','',1,1),(2,'Room no 329','Ladies Hostel','National institute of Technlogy Calicut','Near Kattangal','Calicut','Kerala','673601','India','',2,1),(3,'Room No 327','ladies hostel','nitc','kattangal','calicut','kerala','673601','india','',1,2),(4,'room no 329','lh','nitc','kattangal','calicut','kerala','673601','India','',2,2);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address_type`
--

DROP TABLE IF EXISTS `address_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_type` (
  `ADDRESS_TYPE_ID` int(11) NOT NULL,
  `TYPE` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ADDRESS_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_type`
--

LOCK TABLES `address_type` WRITE;
/*!40000 ALTER TABLE `address_type` DISABLE KEYS */;
INSERT INTO `address_type` VALUES (1,'Shipping Address'),(2,'Billing Address'),(3,'User Address');
/*!40000 ALTER TABLE `address_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brand` (
  `BRAND_ID` int(11) NOT NULL AUTO_INCREMENT,
  `BRAND_NAME` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`BRAND_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (1,'Nokia'),(2,'Samsung'),(3,'LG'),(4,'HTC'),(5,'Motorola'),(6,'Micromax'),(7,'Google'),(8,'Sony'),(9,'Lemon'),(10,'Lorem'),(11,'Amazon'),(12,'Karbonn'),(13,'Gionee');
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart` (
  `ID` int(11) NOT NULL,
  `TOTAL_COST` float DEFAULT NULL,
  `USER_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_cart_user1` (`USER_ID`),
  CONSTRAINT `fk_cart_user1` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`UID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,1000,1),(2,10000,2);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_has_product`
--

DROP TABLE IF EXISTS `cart_has_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_has_product` (
  `cart_ID` int(11) NOT NULL,
  `PRODUCT_PID` int(11) NOT NULL,
  `QUANTITY` int(11) DEFAULT NULL,
  `PRICE` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cart_ID`,`PRODUCT_PID`),
  KEY `fk_cart_has_PRODUCT_PRODUCT1` (`PRODUCT_PID`),
  KEY `fk_cart_has_PRODUCT_cart1` (`cart_ID`),
  CONSTRAINT `fk_cart_has_PRODUCT_cart1` FOREIGN KEY (`cart_ID`) REFERENCES `cart` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cart_has_PRODUCT_PRODUCT1` FOREIGN KEY (`PRODUCT_PID`) REFERENCES `product` (`PID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_has_product`
--

LOCK TABLES `cart_has_product` WRITE;
/*!40000 ALTER TABLE `cart_has_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_has_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `CID` int(11) NOT NULL AUTO_INCREMENT,
  `CATEGORY_NAME` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Phone'),(2,'Accessories');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complain`
--

DROP TABLE IF EXISTS `complain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `complain` (
  `COMPLAIN_ID` int(11) NOT NULL AUTO_INCREMENT,
  `COMPLAIN_TYPE` varchar(45) DEFAULT NULL,
  `COMPLAIN_TEXT` varchar(45) DEFAULT NULL,
  `ORDER_ID` int(11) NOT NULL,
  PRIMARY KEY (`COMPLAIN_ID`),
  KEY `fk_complain_order1` (`ORDER_ID`),
  CONSTRAINT `fk_complain_order1` FOREIGN KEY (`ORDER_ID`) REFERENCES `order` (`ORDER_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complain`
--

LOCK TABLES `complain` WRITE;
/*!40000 ALTER TABLE `complain` DISABLE KEYS */;
/*!40000 ALTER TABLE `complain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature`
--

DROP TABLE IF EXISTS `feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feature` (
  `FEATURE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `FEATURE_NAME` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`FEATURE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature`
--

LOCK TABLES `feature` WRITE;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` VALUES (1,'Radio'),(2,'Main Camera'),(3,'Front Camera'),(4,'3G'),(5,'Touchscreen'),(6,'Operating system'),(7,'dual sim'),(8,'Audio'),(9,'Bluetooth'),(10,'High battery backup '),(11,'GPS'),(12,'Display'),(13,'Internal Memory'),(14,'Expandable Memory'),(15,'Processor '),(16,'RAM');
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature_has_category`
--

DROP TABLE IF EXISTS `feature_has_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feature_has_category` (
  `FEATURE_ID` int(11) NOT NULL,
  `CATEGORY_CID` int(11) NOT NULL,
  PRIMARY KEY (`FEATURE_ID`,`CATEGORY_CID`),
  KEY `fk_feature_has_CATEGORY_CATEGORY1` (`CATEGORY_CID`),
  KEY `fk_feature_has_CATEGORY_feature1` (`FEATURE_ID`),
  CONSTRAINT `fk_feature_has_CATEGORY_CATEGORY1` FOREIGN KEY (`CATEGORY_CID`) REFERENCES `category` (`CID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_feature_has_CATEGORY_feature1` FOREIGN KEY (`FEATURE_ID`) REFERENCES `feature` (`FEATURE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature_has_category`
--

LOCK TABLES `feature_has_category` WRITE;
/*!40000 ALTER TABLE `feature_has_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `feature_has_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `ORDER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PAYMENT_TYPE_ID` int(11) NOT NULL,
  `SHIPPING_ADD_ID` int(11) NOT NULL,
  `PAYMENT_ID` int(11) NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `CART_ID` int(11) NOT NULL,
  `ORDER_DATE` date DEFAULT NULL,
  PRIMARY KEY (`ORDER_ID`),
  KEY `fk_order_payment_type1` (`PAYMENT_TYPE_ID`),
  KEY `fk_order_address1` (`SHIPPING_ADD_ID`),
  KEY `fk_order_payment1` (`PAYMENT_ID`),
  KEY `fk_order_user1` (`USER_ID`),
  KEY `fk_order_cart1` (`CART_ID`),
  CONSTRAINT `fk_order_address1` FOREIGN KEY (`SHIPPING_ADD_ID`) REFERENCES `address` (`ADD_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_cart1` FOREIGN KEY (`CART_ID`) REFERENCES `cart` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_payment1` FOREIGN KEY (`PAYMENT_ID`) REFERENCES `payment` (`PAYMENT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_payment_type1` FOREIGN KEY (`PAYMENT_TYPE_ID`) REFERENCES `payment_type` (`PAYMENT_TYPE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_user1` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`UID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,2,1,1,1,1,'2014-01-12'),(2,2,3,2,2,2,'2014-06-16'),(3,2,4,3,2,2,'2014-06-01');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_has_product`
--

DROP TABLE IF EXISTS `order_has_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_has_product` (
  `ORDER_ID` int(11) NOT NULL,
  `PRODUCT_ID` int(11) NOT NULL,
  `PRODUCT_COUNT` int(11) DEFAULT NULL,
  PRIMARY KEY (`ORDER_ID`,`PRODUCT_ID`),
  KEY `fk_order_has_product_product1` (`PRODUCT_ID`),
  KEY `fk_order_has_product_order1` (`ORDER_ID`),
  CONSTRAINT `fk_order_has_product_order1` FOREIGN KEY (`ORDER_ID`) REFERENCES `order` (`ORDER_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_has_product_product1` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `product` (`PID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_has_product`
--

LOCK TABLES `order_has_product` WRITE;
/*!40000 ALTER TABLE `order_has_product` DISABLE KEYS */;
INSERT INTO `order_has_product` VALUES (1,1,1),(2,14,1),(2,23,1),(3,4,1);
/*!40000 ALTER TABLE `order_has_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `PAYMENT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `BILLING_ADD_ID` int(11) NOT NULL,
  `AMOUNT_TO_BE_PAID` float DEFAULT NULL,
  PRIMARY KEY (`PAYMENT_ID`),
  KEY `fk_payment_address1` (`BILLING_ADD_ID`),
  CONSTRAINT `fk_payment_address1` FOREIGN KEY (`BILLING_ADD_ID`) REFERENCES `address` (`ADD_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,2,1000),(2,3,10000),(3,4,1000);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_type`
--

DROP TABLE IF EXISTS `payment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_type` (
  `PAYMENT_TYPE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `TYPE` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`PAYMENT_TYPE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_type`
--

LOCK TABLES `payment_type` WRITE;
/*!40000 ALTER TABLE `payment_type` DISABLE KEYS */;
INSERT INTO `payment_type` VALUES (1,'online'),(2,'on dilivery');
/*!40000 ALTER TABLE `payment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `PID` int(11) NOT NULL,
  `PRICE` float DEFAULT NULL,
  `RELEASE_DATE` date DEFAULT NULL,
  `WARRANTY` date DEFAULT NULL,
  `QUANTITY` int(11) DEFAULT '0',
  `BRAND_ID` int(11) NOT NULL,
  `CATEGORY_CID` int(11) NOT NULL,
  `PRODUCT_NAME` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`PID`),
  KEY `fk_PRODUCT_brand1` (`BRAND_ID`),
  KEY `fk_product_CATEGORY1` (`CATEGORY_CID`),
  CONSTRAINT `fk_PRODUCT_brand1` FOREIGN KEY (`BRAND_ID`) REFERENCES `brand` (`BRAND_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_CATEGORY1` FOREIGN KEY (`CATEGORY_CID`) REFERENCES `category` (`CID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,22499,'0000-00-00','0000-00-00',50,2,1,'Samsung Galaxy S3 Neo(Gt â€“ 19300111)'),(2,41999,'0000-00-00','0000-00-00',50,2,1,'Samsung Galaxy S5'),(3,19249,'0000-00-00','0000-00-00',50,2,1,'Samsung Galaxy Grand 2'),(4,20000,'0000-00-00','0000-00-00',50,6,1,'Micromax Canvas Doodle a111'),(5,3808,'0000-00-00','0000-00-00',50,6,1,'Micromax Bolt a58'),(6,1289,'0000-00-00','0000-00-00',50,6,1,'Micromax X264'),(7,13939,'0000-00-00','0000-00-00',50,6,1,'Micromax Canvas Turbo a250'),(8,5999,'0000-00-00','0000-00-00',50,8,1,'XPERIA_E'),(9,11799,'0000-00-00','0000-00-00',50,8,1,'XPERIA_J'),(10,16613,'0000-00-00','0000-00-00',50,8,1,'XPERIA_C'),(11,11495,'0000-00-00','0000-00-00',50,8,1,'XPERIA_L'),(12,6499,'0000-00-00','0000-00-00',50,8,1,'XPERIA_M'),(13,27399,'0000-00-00','0000-00-00',50,8,1,'XPERIA_Z'),(14,5799,'0000-00-00','0000-00-00',50,8,1,'TIPO'),(15,23000,'0000-00-00','0000-00-00',50,4,1,'HTC Desire 816'),(16,50700,'0000-00-00','0000-00-00',50,4,1,'HTC One Max'),(17,41500,'0000-00-00','0000-00-00',50,3,1,'LG G2'),(18,69999,'0000-00-00','0000-00-00',50,3,1,'LG GFLEX'),(19,11489,'0000-00-00','0000-00-00',50,1,1,'Nokia XL'),(20,6788,'0000-00-00','0000-00-00',50,1,1,'Nokia X'),(21,12499,'0000-00-00','0000-00-00',50,5,1,'Moto-g'),(22,23999,'0000-00-00','0000-00-00',50,5,1,'Moto-x'),(23,9200,'0000-00-00','0000-00-00',50,5,1,'Moto-e'),(24,16950,'0000-00-00','0000-00-00',50,7,1,'Nexus-4'),(25,28500,'0000-00-00','0000-00-00',50,7,1,'Nexus-5');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_has_feature`
--

DROP TABLE IF EXISTS `product_has_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_has_feature` (
  `PRODUCT_ID` int(11) NOT NULL,
  `FEATURE_ID` int(11) NOT NULL,
  `FEATURE_DISCRIPTION` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`PRODUCT_ID`,`FEATURE_ID`),
  KEY `fk_product_has_features_features1` (`FEATURE_ID`),
  KEY `fk_product_has_features_product1` (`PRODUCT_ID`),
  CONSTRAINT `fk_product_has_features_features1` FOREIGN KEY (`FEATURE_ID`) REFERENCES `feature` (`FEATURE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_features_product1` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `product` (`PID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_has_feature`
--

LOCK TABLES `product_has_feature` WRITE;
/*!40000 ALTER TABLE `product_has_feature` DISABLE KEYS */;
INSERT INTO `product_has_feature` VALUES (1,1,'yes'),(1,2,'8MP'),(1,3,'1.9MP'),(1,4,'yes'),(1,5,'yes'),(1,6,'Android Jelly bean 4.3'),(1,7,'yes'),(2,1,'yes'),(2,2,'16MP'),(2,3,'2MP'),(2,4,'Yes .. 4G available :P'),(2,5,'yes'),(2,6,'Android 4.4.2 Kitkat'),(2,7,'yes'),(3,1,'yes'),(3,2,'8MP'),(3,3,'1.9MP'),(3,4,'yes'),(3,5,'yes'),(3,6,'Android'),(3,7,'yes'),(4,1,'yes'),(4,2,'8MP'),(4,3,'2MP'),(4,4,'yes'),(4,5,'yes'),(4,6,'android jelly bean 4.1.2'),(4,7,'yes'),(5,1,'yes'),(5,2,'2mp'),(5,5,'yes'),(5,6,'android jelly bean 4.2'),(5,7,'yes'),(6,1,'yes'),(6,2,'0.3MP'),(6,7,'yes'),(7,1,'yes'),(7,2,'13MP'),(7,3,'5MP'),(7,4,'yes'),(7,5,'yes'),(7,6,'android 4.2.1'),(7,7,'yes'),(8,1,'yes'),(8,2,'3.2 MP'),(8,4,'Yes'),(8,5,'yes'),(8,6,'android 4.1'),(8,7,'optional'),(9,1,'yes'),(9,2,'5.0 MP'),(9,3,'VGA'),(9,4,'yes'),(9,5,'yes'),(9,6,'android 4.0'),(10,1,'yes'),(10,2,'8 MP'),(10,3,'VGA'),(10,4,'yes'),(10,5,'yes'),(10,6,'android 4.2'),(11,1,'yes'),(11,2,'8 MP'),(11,3,'VGA'),(11,4,'yes'),(11,5,'yes'),(11,6,'android 4.1'),(11,7,'no'),(12,1,'yes'),(12,2,'5 MP'),(12,3,'VGA'),(12,4,'yes'),(12,5,'yes'),(12,6,'android 4.1'),(12,7,'optional'),(13,1,'yes'),(13,2,'13.1 MP'),(13,3,'2.2 MP'),(13,4,'yes'),(13,5,'yes'),(13,6,'android 4.3'),(14,1,'yes'),(14,2,'3.2 MP'),(14,4,'yes'),(14,5,'yes'),(14,6,'android 4.0'),(14,7,'optional'),(15,1,'yes'),(15,2,'10MP'),(15,3,'2.1MP'),(15,4,'yes'),(15,5,'yes'),(15,6,'android 4.2'),(15,7,'yes'),(16,2,'13MP'),(16,3,'5MP'),(16,4,'yes'),(16,5,'yes'),(16,6,'android 4.2.2'),(16,7,'yes'),(17,1,'yes'),(17,2,'13MP'),(17,3,'2.1MP'),(17,4,'yes'),(17,5,'yes'),(17,6,'android 4.2.2'),(18,1,'yes'),(18,2,'13MP'),(18,3,'2.1MP'),(18,4,'yes'),(18,5,'yes'),(18,6,'android 4.2.2'),(19,2,'5MP'),(19,3,'2MP'),(19,4,'yes'),(19,5,'yes'),(19,6,'Windows 8'),(19,7,'yes'),(20,1,'yes'),(20,2,'3MP'),(20,4,'yes'),(20,5,'yes'),(20,6,'android'),(20,7,'yes'),(21,1,'yes'),(21,2,'5MP'),(21,3,'1.3MP'),(21,4,'yes'),(21,5,'yes'),(21,6,'android 4.4'),(21,7,'yes'),(22,2,'10MP'),(22,3,'2MP'),(22,4,'yes'),(22,5,'yes'),(22,6,'android 4.4'),(22,7,'yes'),(23,1,'yes'),(23,2,'5MP'),(23,4,'yes'),(23,5,'yes'),(23,6,'android 4.4'),(23,7,'yes'),(24,2,'8MP'),(24,3,'1.3MP'),(24,4,'yes'),(24,5,'yes'),(24,6,'android 4.4'),(24,7,'yes'),(25,2,'8MP'),(25,3,'1.3MP'),(25,4,'yes'),(25,5,'yes'),(25,6,'android 4.4'),(25,7,'yes');
/*!40000 ALTER TABLE `product_has_feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `REVIEW_ID` int(11) NOT NULL DEFAULT '0',
  `RATING` int(11) DEFAULT '5',
  `COMMENT` varchar(45) DEFAULT NULL,
  `PRODUCT_ID` int(11) NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `REVIEW_DATE` date DEFAULT NULL,
  PRIMARY KEY (`REVIEW_ID`),
  KEY `fk_review_product1` (`PRODUCT_ID`),
  KEY `fk_review_user1` (`USER_ID`),
  CONSTRAINT `fk_review_product1` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `product` (`PID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_user1` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`UID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,5,'Very Nice',1,1,'2014-01-12');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `ROLE_ID` int(11) NOT NULL,
  `ROLE_NAME` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Admin'),(2,'Dealer'),(3,'Buyer');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status` (
  `LOCATION` varchar(45) DEFAULT NULL,
  `ORDER_ID` int(11) NOT NULL,
  PRIMARY KEY (`ORDER_ID`),
  KEY `fk_status_order1` (`ORDER_ID`),
  CONSTRAINT `fk_status_order1` FOREIGN KEY (`ORDER_ID`) REFERENCES `order` (`ORDER_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NAME` varchar(45) DEFAULT NULL,
  `PASSWORD` varchar(45) DEFAULT NULL,
  `EMAIL_ID` varchar(45) DEFAULT NULL,
  `PHONE_NUMBER` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`UID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Shrishty','12345','shrishty123chandra@gmail.com','7736205466'),(2,'Pragati','56789','pragati.maan27@gmail.com','7736205966');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_has_role`
--

DROP TABLE IF EXISTS `user_has_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_has_role` (
  `user_UID` int(11) NOT NULL,
  `role_ROLE_ID` int(11) NOT NULL,
  PRIMARY KEY (`user_UID`,`role_ROLE_ID`),
  KEY `fk_user_has_role_role1` (`role_ROLE_ID`),
  KEY `fk_user_has_role_user` (`user_UID`),
  CONSTRAINT `fk_user_has_role_role1` FOREIGN KEY (`role_ROLE_ID`) REFERENCES `role` (`ROLE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_role_user` FOREIGN KEY (`user_UID`) REFERENCES `user` (`UID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_has_role`
--

LOCK TABLES `user_has_role` WRITE;
/*!40000 ALTER TABLE `user_has_role` DISABLE KEYS */;
INSERT INTO `user_has_role` VALUES (1,1),(1,2),(2,2),(2,3);
/*!40000 ALTER TABLE `user_has_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-06-28 17:19:35
