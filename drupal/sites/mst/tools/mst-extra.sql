---- tabela para compatibilidade ----

DROP TABLE IF EXISTS `legacy`;
CREATE TABLE `legacy` (
  `old_id` int(10) unsigned NOT NULL,
  `nid` int(10) unsigned NOT NULL default '0',
  `type` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`old_id`,`nid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
