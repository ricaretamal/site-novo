-- 
-- Table structure for table `views_object_cache` 
-- 
 
DROP TABLE IF EXISTS `views_object_cache`; 
CREATE TABLE `views_object_cache` ( 
  `sid` varchar(64) default NULL, 
  `name` varchar(32) default NULL, 
  `obj` varchar(32) default NULL, 
  `updated` int(10) unsigned NOT NULL default '0', 
  `data` blob, 
  KEY `sid_obj_name` (`sid`,`obj`,`name`), 
  KEY `updated` (`updated`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8; 
 
-- 
-- Dumping data for table `views_object_cache` 
-- 
 
LOCK TABLES `views_object_cache` WRITE; 
/*!40000 ALTER TABLE `views_object_cache` DISABLE KEYS */; 
/*!40000 ALTER TABLE `views_object_cache` ENABLE KEYS */; 
UNLOCK TABLES; 



DROP TABLE IF EXISTS `content_field_image_cache`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `content_field_image_cache` (
  `vid` int(10) unsigned NOT NULL default '0',
  `nid` int(10) unsigned NOT NULL default '0',
  `delta` int(10) unsigned NOT NULL default '0',
  `field_image_cache_fid` int(11) default NULL,
  `field_image_cache_list` tinyint(4) default NULL,
  `field_image_cache_data` text,
  PRIMARY KEY  (`vid`,`delta`),
  KEY `nid` (`nid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

