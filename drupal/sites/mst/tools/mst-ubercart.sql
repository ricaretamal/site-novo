-- MySQL dump 10.11
--
-- Host: localhost    Database: mst_novo
-- ------------------------------------------------------
-- Server version	5.0.51a-24-log

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
-- Table structure for table `uc_cart_products`
--

DROP TABLE IF EXISTS `uc_cart_products`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `uc_cart_products` (
  `cart_id` varchar(32) NOT NULL default '0',
  `nid` int(10) unsigned NOT NULL default '0',
  `qty` smallint(5) unsigned NOT NULL default '0',
  `changed` int(11) NOT NULL default '0',
  `data` text,
  KEY `cart_id` (`cart_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `uc_cart_products`
--

LOCK TABLES `uc_cart_products` WRITE;
/*!40000 ALTER TABLE `uc_cart_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_cart_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_countries`
--

DROP TABLE IF EXISTS `uc_countries`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `uc_countries` (
  `country_id` int(10) unsigned NOT NULL auto_increment,
  `country_name` varchar(255) NOT NULL default '',
  `country_iso_code_2` char(2) NOT NULL default '',
  `country_iso_code_3` char(3) NOT NULL default '',
  `version` smallint(6) NOT NULL default '0',
  PRIMARY KEY  (`country_id`),
  KEY `country_name` (`country_name`)
) ENGINE=MyISAM AUTO_INCREMENT=841 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `uc_countries`
--

LOCK TABLES `uc_countries` WRITE;
/*!40000 ALTER TABLE `uc_countries` DISABLE KEYS */;
INSERT INTO `uc_countries` VALUES (840,'United States','US','USA',1),(124,'Canada','CA','CAN',1);
/*!40000 ALTER TABLE `uc_countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_order_admin_comments`
--

DROP TABLE IF EXISTS `uc_order_admin_comments`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `uc_order_admin_comments` (
  `comment_id` int(10) unsigned NOT NULL auto_increment,
  `order_id` int(10) unsigned NOT NULL default '0',
  `uid` int(10) unsigned NOT NULL default '0',
  `message` text,
  `created` int(11) NOT NULL default '0',
  PRIMARY KEY  (`comment_id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `uc_order_admin_comments`
--

LOCK TABLES `uc_order_admin_comments` WRITE;
/*!40000 ALTER TABLE `uc_order_admin_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_order_admin_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_order_comments`
--

DROP TABLE IF EXISTS `uc_order_comments`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `uc_order_comments` (
  `comment_id` int(10) unsigned NOT NULL auto_increment,
  `order_id` int(10) unsigned NOT NULL default '0',
  `uid` int(10) unsigned NOT NULL default '0',
  `order_status` varchar(32) NOT NULL default '',
  `notified` tinyint(4) NOT NULL default '0',
  `message` text,
  `created` int(11) NOT NULL default '0',
  PRIMARY KEY  (`comment_id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `uc_order_comments`
--

LOCK TABLES `uc_order_comments` WRITE;
/*!40000 ALTER TABLE `uc_order_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_order_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_order_line_items`
--

DROP TABLE IF EXISTS `uc_order_line_items`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `uc_order_line_items` (
  `line_item_id` int(10) unsigned NOT NULL auto_increment,
  `order_id` int(10) unsigned NOT NULL default '0',
  `type` varchar(32) NOT NULL default '',
  `title` varchar(128) NOT NULL default '',
  `amount` decimal(15,3) NOT NULL default '0.000',
  `weight` smallint(6) NOT NULL default '0',
  `data` text,
  PRIMARY KEY  (`line_item_id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `uc_order_line_items`
--

LOCK TABLES `uc_order_line_items` WRITE;
/*!40000 ALTER TABLE `uc_order_line_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_order_line_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_order_log`
--

DROP TABLE IF EXISTS `uc_order_log`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `uc_order_log` (
  `order_log_id` int(10) unsigned NOT NULL auto_increment,
  `order_id` int(10) unsigned NOT NULL default '0',
  `uid` int(10) unsigned NOT NULL default '0',
  `changes` text,
  `created` int(11) NOT NULL default '0',
  PRIMARY KEY  (`order_log_id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `uc_order_log`
--

LOCK TABLES `uc_order_log` WRITE;
/*!40000 ALTER TABLE `uc_order_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_order_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_order_products`
--

DROP TABLE IF EXISTS `uc_order_products`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `uc_order_products` (
  `order_product_id` int(10) unsigned NOT NULL auto_increment,
  `order_id` int(10) unsigned NOT NULL default '0',
  `nid` int(10) unsigned NOT NULL default '0',
  `title` varchar(128) NOT NULL default '',
  `manufacturer` varchar(32) NOT NULL default '',
  `model` varchar(255) NOT NULL default '',
  `qty` smallint(5) unsigned NOT NULL default '0',
  `cost` decimal(15,3) NOT NULL default '0.000',
  `price` decimal(15,3) NOT NULL default '0.000',
  `weight` float NOT NULL default '0',
  `data` text,
  PRIMARY KEY  (`order_product_id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `uc_order_products`
--

LOCK TABLES `uc_order_products` WRITE;
/*!40000 ALTER TABLE `uc_order_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_order_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_order_statuses`
--

DROP TABLE IF EXISTS `uc_order_statuses`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `uc_order_statuses` (
  `order_status_id` varchar(32) NOT NULL default '',
  `title` varchar(48) NOT NULL default '',
  `state` varchar(32) NOT NULL default '',
  `weight` smallint(6) NOT NULL default '0',
  `locked` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`order_status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `uc_order_statuses`
--

LOCK TABLES `uc_order_statuses` WRITE;
/*!40000 ALTER TABLE `uc_order_statuses` DISABLE KEYS */;
INSERT INTO `uc_order_statuses` VALUES ('canceled','Canceled','canceled',-20,1),('in_checkout','In checkout','in_checkout',-10,1),('pending','Pending','post_checkout',0,1),('processing','Processando','post_checkout',5,1),('completed','Completed','completed',20,1);
/*!40000 ALTER TABLE `uc_order_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_orders`
--

DROP TABLE IF EXISTS `uc_orders`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `uc_orders` (
  `order_id` int(10) unsigned NOT NULL auto_increment,
  `uid` int(10) unsigned NOT NULL default '0',
  `order_status` varchar(32) NOT NULL default '',
  `order_total` decimal(15,3) NOT NULL default '0.000',
  `primary_email` varchar(96) NOT NULL default '',
  `delivery_first_name` varchar(255) NOT NULL default '',
  `delivery_last_name` varchar(255) NOT NULL default '',
  `delivery_phone` varchar(255) NOT NULL default '',
  `delivery_company` varchar(255) NOT NULL default '',
  `delivery_street1` varchar(255) NOT NULL default '',
  `delivery_street2` varchar(255) NOT NULL default '',
  `delivery_city` varchar(255) NOT NULL default '',
  `delivery_zone` mediumint(8) unsigned NOT NULL default '0',
  `delivery_postal_code` varchar(255) NOT NULL default '',
  `delivery_country` mediumint(8) unsigned NOT NULL default '0',
  `billing_first_name` varchar(255) NOT NULL default '',
  `billing_last_name` varchar(255) NOT NULL default '',
  `billing_phone` varchar(255) NOT NULL default '',
  `billing_company` varchar(255) NOT NULL default '',
  `billing_street1` varchar(255) NOT NULL default '',
  `billing_street2` varchar(255) NOT NULL default '',
  `billing_city` varchar(255) NOT NULL default '',
  `billing_zone` mediumint(8) unsigned NOT NULL default '0',
  `billing_postal_code` varchar(255) NOT NULL default '',
  `billing_country` mediumint(8) unsigned NOT NULL default '0',
  `payment_method` varchar(32) NOT NULL default '',
  `data` text,
  `created` int(11) NOT NULL default '0',
  `modified` int(11) NOT NULL default '0',
  `host` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`order_id`),
  KEY `uid` (`uid`),
  KEY `order_status` (`order_status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `uc_orders`
--

LOCK TABLES `uc_orders` WRITE;
/*!40000 ALTER TABLE `uc_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_product_classes`
--

DROP TABLE IF EXISTS `uc_product_classes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `uc_product_classes` (
  `pcid` varchar(32) NOT NULL default '',
  `name` varchar(255) NOT NULL default '',
  `description` text,
  PRIMARY KEY  (`pcid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `uc_product_classes`
--

LOCK TABLES `uc_product_classes` WRITE;
/*!40000 ALTER TABLE `uc_product_classes` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_product_classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_product_features`
--

DROP TABLE IF EXISTS `uc_product_features`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `uc_product_features` (
  `pfid` int(10) unsigned NOT NULL auto_increment,
  `nid` int(10) unsigned NOT NULL default '0',
  `fid` varchar(32) NOT NULL default '',
  `description` text,
  PRIMARY KEY  (`pfid`),
  KEY `nid` (`nid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `uc_product_features`
--

LOCK TABLES `uc_product_features` WRITE;
/*!40000 ALTER TABLE `uc_product_features` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_product_features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_products`
--

DROP TABLE IF EXISTS `uc_products`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `uc_products` (
  `vid` int(10) unsigned NOT NULL default '0',
  `nid` int(10) unsigned NOT NULL default '0',
  `model` varchar(255) NOT NULL default '',
  `list_price` decimal(15,3) NOT NULL default '0.000',
  `cost` decimal(15,3) NOT NULL default '0.000',
  `sell_price` decimal(15,3) NOT NULL default '0.000',
  `weight` float NOT NULL default '0',
  `weight_units` varchar(255) NOT NULL default 'lb',
  `length` float NOT NULL default '0',
  `width` float NOT NULL default '0',
  `height` float NOT NULL default '0',
  `length_units` varchar(255) NOT NULL default 'in',
  `pkg_qty` smallint(5) unsigned NOT NULL default '1',
  `default_qty` smallint(5) unsigned NOT NULL default '1',
  `unique_hash` varchar(32) NOT NULL default 'd41d8cd98f00b204e9800998ecf8427e',
  `ordering` tinyint(4) NOT NULL default '0',
  `shippable` tinyint(3) unsigned NOT NULL default '1',
  PRIMARY KEY  (`vid`),
  KEY `nid` (`nid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `uc_products`
--

LOCK TABLES `uc_products` WRITE;
/*!40000 ALTER TABLE `uc_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_store_footers`
--

DROP TABLE IF EXISTS `uc_store_footers`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `uc_store_footers` (
  `path_hash` varchar(32) NOT NULL default '',
  `message` text,
  PRIMARY KEY  (`path_hash`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `uc_store_footers`
--

LOCK TABLES `uc_store_footers` WRITE;
/*!40000 ALTER TABLE `uc_store_footers` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_store_footers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_zones`
--

DROP TABLE IF EXISTS `uc_zones`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `uc_zones` (
  `zone_id` int(10) unsigned NOT NULL auto_increment,
  `zone_country_id` int(10) unsigned NOT NULL default '0',
  `zone_code` varchar(32) NOT NULL default '',
  `zone_name` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`zone_id`),
  KEY `zone_code` (`zone_code`),
  KEY `zone_country_id` (`zone_country_id`)
) ENGINE=MyISAM AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `uc_zones`
--

LOCK TABLES `uc_zones` WRITE;
/*!40000 ALTER TABLE `uc_zones` DISABLE KEYS */;
INSERT INTO `uc_zones` VALUES (1,840,'AL','Alabama'),(2,840,'AK','Alaska'),(3,840,'AS','American Samoa'),(4,840,'AZ','Arizona'),(5,840,'AR','Arkansas'),(6,840,'AF','Armed Forces Africa'),(7,840,'AA','Armed Forces Americas'),(8,840,'AC','Armed Forces Canada'),(9,840,'AE','Armed Forces Europe'),(10,840,'AM','Armed Forces Middle East'),(11,840,'AP','Armed Forces Pacific'),(12,840,'CA','California'),(13,840,'CO','Colorado'),(14,840,'CT','Connecticut'),(15,840,'DE','Delaware'),(16,840,'DC','District of Columbia'),(17,840,'FM','Federated States Of Micronesia'),(18,840,'FL','Florida'),(19,840,'GA','Georgia'),(20,840,'GU','Guam'),(21,840,'HI','Hawaii'),(22,840,'ID','Idaho'),(23,840,'IL','Illinois'),(24,840,'IN','Indiana'),(25,840,'IA','Iowa'),(26,840,'KS','Kansas'),(27,840,'KY','Kentucky'),(28,840,'LA','Louisiana'),(29,840,'ME','Maine'),(30,840,'MH','Marshall Islands'),(31,840,'MD','Maryland'),(32,840,'MA','Massachusetts'),(33,840,'MI','Michigan'),(34,840,'MN','Minnesota'),(35,840,'MS','Mississippi'),(36,840,'MO','Missouri'),(37,840,'MT','Montana'),(38,840,'NE','Nebraska'),(39,840,'NV','Nevada'),(40,840,'NH','New Hampshire'),(41,840,'NJ','New Jersey'),(42,840,'NM','New Mexico'),(43,840,'NY','New York'),(44,840,'NC','North Carolina'),(45,840,'ND','North Dakota'),(46,840,'MP','Northern Mariana Islands'),(47,840,'OH','Ohio'),(48,840,'OK','Oklahoma'),(49,840,'OR','Oregon'),(50,840,'PW','Palau'),(51,840,'PA','Pennsylvania'),(52,840,'PR','Puerto Rico'),(53,840,'RI','Rhode Island'),(54,840,'SC','South Carolina'),(55,840,'SD','South Dakota'),(56,840,'TN','Tennessee'),(57,840,'TX','Texas'),(58,840,'UT','Utah'),(59,840,'VT','Vermont'),(60,840,'VI','Virgin Islands'),(61,840,'VA','Virginia'),(62,840,'WA','Washington'),(63,840,'WV','West Virginia'),(64,840,'WI','Wisconsin'),(65,840,'WY','Wyoming'),(66,124,'AB','Alberta'),(67,124,'BC','British Columbia'),(68,124,'MB','Manitoba'),(69,124,'NF','Newfoundland'),(70,124,'NB','New Brunswick'),(71,124,'NS','Nova Scotia'),(72,124,'NT','Northwest Territories'),(73,124,'NU','Nunavut'),(74,124,'ON','Ontario'),(75,124,'PE','Prince Edward Island'),(76,124,'QC','Quebec'),(77,124,'SK','Saskatchewan'),(78,124,'YT','Yukon Territory');
/*!40000 ALTER TABLE `uc_zones` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-03-02 20:43:17

