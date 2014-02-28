-- MySQL dump 10.11
--
-- Host: localhost    Database: mst_novo
-- ------------------------------------------------------
-- Server version	5.0.32-Debian_7etch8-log

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
-- Table structure for table `imagecache_preset`
--

DROP TABLE IF EXISTS `imagecache_preset`;
CREATE TABLE `imagecache_preset` (
  `presetid` int(10) unsigned NOT NULL auto_increment,
  `presetname` varchar(255) NOT NULL,
  PRIMARY KEY  (`presetid`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `imagecache_preset`
--

LOCK TABLES `imagecache_preset` WRITE;
/*!40000 ALTER TABLE `imagecache_preset` DISABLE KEYS */;
INSERT INTO `imagecache_preset` VALUES (1,'capa_revistajornal'),(2,'bloco_especial'),(3,'bandeira'),(4,'foto_materia_capa'),(5,'foto_destaque');
/*!40000 ALTER TABLE `imagecache_preset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagecache_action`
--

DROP TABLE IF EXISTS `imagecache_action`;
CREATE TABLE `imagecache_action` (
  `actionid` int(10) unsigned NOT NULL auto_increment,
  `presetid` int(10) unsigned NOT NULL default '0',
  `weight` int(11) NOT NULL default '0',
  `module` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY  (`actionid`),
  KEY `presetid` (`presetid`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `imagecache_action`
--

LOCK TABLES `imagecache_action` WRITE;
/*!40000 ALTER TABLE `imagecache_action` DISABLE KEYS */;
INSERT INTO `imagecache_action` VALUES (1,1,0,'imagecache','imagecache_scale','a:3:{s:5:\"width\";s:5:\"123px\";s:6:\"height\";s:0:\"\";s:7:\"upscale\";i:0;}'),(4,2,0,'imagecache','imagecache_scale','a:3:{s:5:\"width\";s:3:\"258\";s:6:\"height\";s:0:\"\";s:7:\"upscale\";i:0;}'),(5,3,0,'imagecache','imagecache_scale','a:3:{s:5:\"width\";s:0:\"\";s:6:\"height\";s:2:\"60\";s:7:\"upscale\";i:0;}'),(6, 4, 0, 'imagecache', 'imagecache_scale', 'a:3:{s:5:"width";s:5:"200px";s:6:"height";s:5:"200px";s:7:"upscale";i:0;}'),(8,5,0,'imagecache','imagecache_scale','a:3:{s:5:\"width\";s:3:\"230\";s:6:\"height\";s:0:\"\";s:7:\"upscale\";i:0;}');
/*!40000 ALTER TABLE `imagecache_action` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-02-17  1:17:41
