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
-- Table structure for table `content_node_field`
--

DROP TABLE IF EXISTS `content_node_field`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `content_node_field` (
  `field_name` varchar(32) NOT NULL default '',
  `type` varchar(127) NOT NULL default '',
  `global_settings` mediumtext NOT NULL,
  `required` tinyint(4) NOT NULL default '0',
  `multiple` tinyint(4) NOT NULL default '0',
  `db_storage` tinyint(4) NOT NULL default '1',
  `module` varchar(127) NOT NULL default '',
  `db_columns` mediumtext NOT NULL,
  `active` tinyint(4) NOT NULL default '0',
  `locked` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`field_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `content_node_field`
--

LOCK TABLES `content_node_field` WRITE;
/*!40000 ALTER TABLE `content_node_field` DISABLE KEYS */;
INSERT INTO `content_node_field` VALUES ('field_numero','number_integer','a:6:{s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:3:\"min\";s:0:\"\";s:3:\"max\";s:0:\"\";s:14:\"allowed_values\";s:0:\"\";s:18:\"allowed_values_php\";s:0:\"\";}',0,0,1,'number','a:1:{s:5:\"value\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:0;s:8:\"sortable\";b:1;}}',1,0),('field_ano','number_integer','a:6:{s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:3:\"min\";s:4:\"1990\";s:3:\"max\";s:4:\"2020\";s:14:\"allowed_values\";s:0:\"\";s:18:\"allowed_values_php\";s:0:\"\";}',0,0,1,'number','a:1:{s:5:\"value\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:0;s:8:\"sortable\";b:1;}}',1,0),('field_mes','text','a:4:{s:15:\"text_processing\";s:1:\"0\";s:10:\"max_length\";s:0:\"\";s:14:\"allowed_values\";s:166:\"Dez/Jan\r\nJan\r\nJan/Fev\r\nFev\r\nFev/Mar\r\nMar\r\nMar/Abr\r\nAbr\r\nAbr/Mai\r\nMai\r\nMai/Jun\r\nJun\r\nJun/Jul\r\nJul\r\nJul/Ago\r\nAgo\r\nAgo/Set\r\nSet\r\nSet/Out\r\nOut\r\nOut/Nov\r\nNov\r\nNov/Dez\r\nDez\";s:18:\"allowed_values_php\";s:0:\"\";}',0,0,1,'text','a:1:{s:5:\"value\";a:4:{s:4:\"type\";s:4:\"text\";s:4:\"size\";s:3:\"big\";s:8:\"not null\";b:0;s:8:\"sortable\";b:1;}}',1,0),('field_capa', 'filefield', 'a:3:{s:10:"list_field";s:0:"";s:12:"list_default";s:0:"";s:17:"description_field";s:0:"";}', 0, 0, 1, 'filefield', 'a:3:{s:3:"fid";a:3:{s:4:"type";s:3:"int";s:8:"not null";b:0;s:5:"views";b:1;}s:4:"list";a:4:{s:4:"type";s:3:"int";s:4:"size";s:4:"tiny";s:8:"not null";b:0;s:5:"views";b:1;}s:4:"data";a:3:{s:4:"type";s:4:"text";s:9:"serialize";b:1;s:5:"views";b:1;}}', 1, 0),('field_url','link','a:6:{s:10:\"attributes\";a:3:{s:6:\"target\";s:7:\"default\";s:3:\"rel\";s:0:\"\";s:5:\"class\";s:0:\"\";}s:7:\"display\";a:1:{s:10:\"url_cutoff\";s:2:\"80\";}s:3:\"url\";i:0;s:5:\"title\";s:4:\"none\";s:11:\"title_value\";s:0:\"\";s:13:\"enable_tokens\";i:0;}',1,0,1,'link','a:3:{s:3:\"url\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:0;s:8:\"sortable\";b:1;}s:5:\"title\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:0;s:8:\"sortable\";b:1;}s:10:\"attributes\";a:3:{s:4:\"type\";s:4:\"text\";s:4:\"size\";s:6:\"medium\";s:8:\"not null\";b:0;}}',1,0),('field_custo','number_float','a:6:{s:6:\"prefix\";s:2:\"R$\";s:6:\"suffix\";s:0:\"\";s:3:\"min\";s:0:\"\";s:3:\"max\";s:0:\"\";s:14:\"allowed_values\";s:0:\"\";s:18:\"allowed_values_php\";s:0:\"\";}',1,0,1,'number','a:1:{s:5:\"value\";a:3:{s:4:\"type\";s:5:\"float\";s:8:\"not null\";b:0;s:8:\"sortable\";b:1;}}',1,0),('field_estoque','number_decimal','a:9:{s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:3:\"min\";s:0:\"\";s:3:\"max\";s:0:\"\";s:14:\"allowed_values\";s:0:\"\";s:18:\"allowed_values_php\";s:0:\"\";s:9:\"precision\";s:2:\"10\";s:5:\"scale\";s:1:\"2\";s:7:\"decimal\";s:1:\".\";}',0,0,1,'number','a:1:{s:5:\"value\";a:5:{s:4:\"type\";s:7:\"numeric\";s:9:\"precision\";s:2:\"10\";s:5:\"scale\";s:1:\"2\";s:8:\"not null\";b:0;s:8:\"sortable\";b:1;}}',1,0),('field_foto', 'filefield', 'a:3:{s:10:"list_field";s:0:"";s:12:"list_default";s:0:"";s:17:"description_field";s:0:"";}', 0, 0, 1, 'filefield', 'a:3:{s:3:"fid";a:3:{s:4:"type";s:3:"int";s:8:"not null";b:0;s:5:"views";b:1;}s:4:"list";a:4:{s:4:"type";s:3:"int";s:4:"size";s:4:"tiny";s:8:"not null";b:0;s:5:"views";b:1;}s:4:"data";a:3:{s:4:"type";s:4:"text";s:9:"serialize";b:1;s:5:"views";b:1;}}', 1, 0),('field_bandeira', 'filefield', 'a:3:{s:10:"list_field";s:0:"";s:12:"list_default";s:0:"";s:17:"description_field";s:0:"";}', 0, 0, 1, 'filefield', 'a:3:{s:3:"fid";a:3:{s:4:"type";s:3:"int";s:8:"not null";b:0;s:5:"views";b:1;}s:4:"list";a:4:{s:4:"type";s:3:"int";s:4:"size";s:4:"tiny";s:8:"not null";b:0;s:5:"views";b:1;}s:4:"data";a:3:{s:4:"type";s:4:"text";s:9:"serialize";b:1;s:5:"views";b:1;}}', 1, 0),('field_legenda','text','a:4:{s:15:\"text_processing\";s:1:\"0\";s:10:\"max_length\";s:0:\"\";s:14:\"allowed_values\";s:0:\"\";s:18:\"allowed_values_php\";s:0:\"\";}',0,0,1,'text','a:1:{s:5:\"value\";a:4:{s:4:\"type\";s:4:\"text\";s:4:\"size\";s:3:\"big\";s:8:\"not null\";b:0;s:8:\"sortable\";b:1;}}',1,0),('field_image_cache','image','a:4:{s:18:\"force_list_default\";s:1:\"1\";s:12:\"list_default\";s:1:\"0\";s:16:\"show_description\";s:0:\"\";s:15:\"file_formatters\";s:0:\"\";}',0,1,0,'filefield','a:3:{s:3:\"fid\";a:2:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:0;}s:4:\"list\";a:3:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:8:\"not null\";b:0;}s:4:\"data\";a:2:{s:4:\"type\";s:4:\"text\";s:9:\"serialize\";b:1;}}',1,0);
/*!40000 ALTER TABLE `content_node_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_node_field_instance`
--

DROP TABLE IF EXISTS `content_node_field_instance`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `content_node_field_instance` (
  `field_name` varchar(32) NOT NULL default '',
  `type_name` varchar(32) NOT NULL default '',
  `weight` int(11) NOT NULL default '0',
  `label` varchar(255) NOT NULL default '',
  `widget_type` varchar(32) NOT NULL default '',
  `widget_settings` mediumtext NOT NULL,
  `display_settings` mediumtext NOT NULL,
  `description` mediumtext NOT NULL,
  `widget_module` varchar(127) NOT NULL default '',
  `widget_active` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`field_name`,`type_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `content_node_field_instance`
--

LOCK TABLES `content_node_field_instance` WRITE;
/*!40000 ALTER TABLE `content_node_field_instance` DISABLE KEYS */;
INSERT INTO `content_node_field_instance` VALUES ('field_numero','book',-2,'Número','number','a:2:{s:13:\"default_value\";a:1:{i:0;a:2:{s:5:\"value\";s:0:\"\";s:14:\"_error_element\";s:44:\"default_value_widget][field_numero][0][value\";}}s:17:\"default_value_php\";N;}','a:8:{s:6:\"weight\";s:2:\"-2\";s:6:\"parent\";s:0:\"\";s:5:\"label\";a:1:{s:6:\"format\";s:6:\"inline\";}s:6:\"teaser\";a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}s:4:\"full\";a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}i:0;a:1:{s:6:\"format\";s:5:\"above\";}i:1;a:1:{s:6:\"format\";s:7:\"default\";}i:2;a:1:{s:6:\"format\";s:7:\"default\";}}','Número da edição (para páginas pai)','number',1),('field_ano','book',-1,'Ano','number','a:2:{s:13:\"default_value\";a:1:{i:0;a:2:{s:5:\"value\";s:0:\"\";s:14:\"_error_element\";s:41:\"default_value_widget][field_ano][0][value\";}}s:17:\"default_value_php\";N;}','a:8:{s:6:\"weight\";s:2:\"-1\";s:6:\"parent\";s:0:\"\";s:5:\"label\";a:1:{s:6:\"format\";s:6:\"hidden\";}s:6:\"teaser\";a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}s:4:\"full\";a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}i:0;a:1:{s:6:\"format\";s:5:\"above\";}i:1;a:1:{s:6:\"format\";s:7:\"default\";}i:2;a:1:{s:6:\"format\";s:7:\"default\";}}','','number',1),('field_mes','book',0,'Mês','optionwidgets_select','a:2:{s:13:\"default_value\";a:1:{i:0;a:1:{s:5:\"value\";s:0:\"\";}}s:17:\"default_value_php\";N;}','a:8:{s:6:\"weight\";i:0;s:6:\"parent\";s:0:\"\";s:5:\"label\";a:1:{s:6:\"format\";s:6:\"hidden\";}s:6:\"teaser\";a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}s:4:\"full\";a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}i:0;a:1:{s:6:\"format\";s:5:\"above\";}i:1;a:1:{s:6:\"format\";s:7:\"default\";}i:2;a:1:{s:6:\"format\";s:7:\"default\";}}','','optionwidgets',1),('field_capa', 'book', 31, 'Capa', 'imagefield_widget', 'a:14:{s:15:"file_extensions";s:16:"jpg jpeg png gif";s:9:"file_path";s:0:"";s:18:"progress_indicator";s:3:"bar";s:21:"max_filesize_per_file";s:0:"";s:21:"max_filesize_per_node";s:0:"";s:14:"max_resolution";s:1:"0";s:14:"min_resolution";s:1:"0";s:3:"alt";s:0:"";s:10:"custom_alt";i:0;s:5:"title";s:0:"";s:12:"custom_title";i:0;s:10:"title_type";s:9:"textfield";s:13:"default_image";N;s:17:"use_default_image";i:0;}', 'a:8:{s:5:"label";a:2:{s:6:"format";s:5:"above";s:7:"exclude";i:0;}i:5;a:2:{s:6:"format";s:11:"image_plain";s:7:"exclude";i:0;}s:6:"teaser";a:2:{s:6:"format";s:11:"image_plain";s:7:"exclude";i:0;}s:4:"full";a:2:{s:6:"format";s:11:"image_plain";s:7:"exclude";i:0;}i:4;a:2:{s:6:"format";s:11:"image_plain";s:7:"exclude";i:0;}i:2;a:2:{s:6:"format";s:11:"image_plain";s:7:"exclude";i:0;}i:3;a:2:{s:6:"format";s:11:"image_plain";s:7:"exclude";i:0;}s:5:"token";a:2:{s:6:"format";s:11:"image_plain";s:7:"exclude";i:0;}}', '', 'imagefield', 1),('field_url','links',-2,'URL','link','a:2:{s:13:\"default_value\";a:1:{i:0;a:2:{s:5:\"title\";s:0:\"\";s:3:\"url\";s:0:\"\";}}s:17:\"default_value_php\";N;}','a:9:{s:6:\"weight\";s:2:\"-2\";s:6:\"parent\";s:0:\"\";s:5:\"label\";a:1:{s:6:\"format\";s:6:\"hidden\";}s:6:\"teaser\";a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}s:4:\"full\";a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}i:4;a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}i:2;a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}i:3;a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}s:5:\"token\";a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}}','','link',1),('field_custo','produto',-3,'Custo','number','a:2:{s:13:\"default_value\";a:1:{i:0;a:2:{s:5:\"value\";s:0:\"\";s:14:\"_error_element\";s:43:\"default_value_widget][field_custo][0][value\";}}s:17:\"default_value_php\";N;}','a:9:{s:6:\"weight\";s:2:\"-3\";s:6:\"parent\";s:0:\"\";s:5:\"label\";a:1:{s:6:\"format\";s:5:\"above\";}s:6:\"teaser\";a:2:{s:6:\"format\";s:4:\"be_2\";s:7:\"exclude\";i:0;}s:4:\"full\";a:2:{s:6:\"format\";s:4:\"be_2\";s:7:\"exclude\";i:0;}i:4;a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}i:2;a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}i:3;a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}s:5:\"token\";a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}}','Custo em R$','number',1),('field_estoque','produto',-1,'Estoque','number','a:2:{s:13:\"default_value\";a:1:{i:0;a:2:{s:5:\"value\";s:0:\"\";s:14:\"_error_element\";s:45:\"default_value_widget][field_estoque][0][value\";}}s:17:\"default_value_php\";N;}','a:9:{s:6:\"weight\";s:2:\"-1\";s:6:\"parent\";s:0:\"\";s:5:\"label\";a:1:{s:6:\"format\";s:6:\"hidden\";}s:6:\"teaser\";a:2:{s:6:\"format\";s:6:\"hidden\";s:7:\"exclude\";i:1;}s:4:\"full\";a:2:{s:6:\"format\";s:6:\"hidden\";s:7:\"exclude\";i:1;}i:4;a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}i:2;a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}i:3;a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}s:5:\"token\";a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}}','Quantidade em estoque. Não é exibido para usuários e usuárias','number',1),('field_foto','story',-3,'Foto','imagefield_widget','a:11:{s:15:\"file_extensions\";s:16:\"jpg jpeg png gif\";s:9:\"file_path\";s:0:\"\";s:21:\"max_filesize_per_file\";s:0:\"\";s:21:\"max_filesize_per_node\";s:0:\"\";s:12:\"file_widgets\";N;s:14:\"max_resolution\";s:7:\"640x640\";s:14:\"min_resolution\";s:1:\"0\";s:3:\"alt\";s:0:\"\";s:10:\"custom_alt\";i:0;s:5:\"title\";s:0:\"\";s:12:\"custom_title\";i:0;}','a:9:{s:6:\"weight\";s:2:\"-2\";s:6:\"parent\";s:0:\"\";s:5:\"label\";a:1:{s:6:\"format\";s:6:\"hidden\";}s:6:\"teaser\";a:2:{s:6:\"format\";s:25:\"foto_materia_capa_default\";s:7:\"exclude\";i:0;}s:4:\"full\";a:2:{s:6:\"format\";s:11:\"image_plain\";s:7:\"exclude\";i:0;}i:4;a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}i:2;a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}i:3;a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}s:5:\"token\";a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}}','','imagefield',1),('field_bandeira','links',-3,'Bandeira','imagefield_widget','a:11:{s:15:\"file_extensions\";s:16:\"jpg jpeg png gif\";s:9:\"file_path\";s:0:\"\";s:21:\"max_filesize_per_file\";s:0:\"\";s:21:\"max_filesize_per_node\";s:0:\"\";s:12:\"file_widgets\";N;s:14:\"max_resolution\";s:7:\"640x480\";s:14:\"min_resolution\";s:1:\"0\";s:3:\"alt\";s:0:\"\";s:10:\"custom_alt\";i:0;s:5:\"title\";s:0:\"\";s:12:\"custom_title\";i:0;}','a:9:{s:6:\"weight\";s:2:\"-3\";s:6:\"parent\";s:0:\"\";s:5:\"label\";a:1:{s:6:\"format\";s:6:\"hidden\";}s:6:\"teaser\";a:2:{s:6:\"format\";s:16:\"bandeira_default\";s:7:\"exclude\";i:0;}s:4:\"full\";a:2:{s:6:\"format\";s:16:\"bandeira_default\";s:7:\"exclude\";i:0;}i:4;a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}i:2;a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}i:3;a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}s:5:\"token\";a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}}','','imagefield',1),('field_legenda','story',-2,'Legenda','text_textfield','a:4:{s:4:\"rows\";i:5;s:4:\"size\";s:3:\"120\";s:13:\"default_value\";a:1:{i:0;a:2:{s:5:\"value\";s:0:\"\";s:14:\"_error_element\";s:45:\"default_value_widget][field_legenda][0][value\";}}s:17:\"default_value_php\";N;}','a:9:{s:6:\"weight\";s:2:\"-1\";s:6:\"parent\";s:0:\"\";s:5:\"label\";a:1:{s:6:\"format\";s:6:\"hidden\";}s:6:\"teaser\";a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}s:4:\"full\";a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}i:4;a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}i:2;a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}i:3;a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}s:5:\"token\";a:2:{s:6:\"format\";s:7:\"default\";s:7:\"exclude\";i:0;}}','Legenda da imagem','text',1),('field_image_cache','product',-2,'Imagem','imagefield_widget','a:11:{s:15:\"file_extensions\";s:20:\"gif jpg jpeg png bmp\";s:9:\"file_path\";N;s:21:\"max_filesize_per_file\";N;s:21:\"max_filesize_per_node\";N;s:12:\"file_widgets\";N;s:14:\"max_resolution\";N;s:14:\"min_resolution\";N;s:3:\"alt\";N;s:10:\"custom_alt\";s:1:\"1\";s:5:\"title\";N;s:12:\"custom_title\";s:1:\"1\";}','a:4:{s:5:\"label\";a:1:{s:6:\"format\";s:6:\"hidden\";}s:6:\"teaser\";a:1:{s:6:\"format\";s:6:\"hidden\";}s:4:\"full\";a:1:{s:6:\"format\";s:6:\"hidden\";}i:4;a:1:{s:6:\"format\";s:6:\"hidden\";}}','','imagefield',1);
/*!40000 ALTER TABLE `content_node_field_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_type_product`
--

DROP TABLE IF EXISTS `content_type_product`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `content_type_product` (
  `vid` int(10) unsigned NOT NULL default '0',
  `nid` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`vid`),
  KEY `nid` (`nid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `content_type_product`
--

LOCK TABLES `content_type_product` WRITE;
/*!40000 ALTER TABLE `content_type_product` DISABLE KEYS */;
INSERT INTO `content_type_product` VALUES (6088,6088);
/*!40000 ALTER TABLE `content_type_product` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-03-03 20:00:49
