---- O NID esta definido como 8218 - talvez precise mudar


INSERT INTO `node` (`nid`, `vid`, `type`, `language`, `title`, `uid`, `status`, `created`, `changed`, `comment`, `promote`, `moderate`, `sticky`, `tnid`, `translate`) VALUES
(8218, 8218, 'page', 'pt-br', 'Redirecionando...', 1, 1, $time, $time, 1, 0, 0, 0, 0, 0);


INSERT INTO node_revisions (nid, vid, uid, title, body, teaser, log, timestamp, format) VALUES
(8218, 8218, 1, 'Redirecionando...', '<?php\r\nglobal $base_url;\r\n\r\n$cd = $_REQUEST[''cd''];\r\n\r\nif (!is_numeric($cd)) {\r\n  header("Location: $base_url");\r\n  exit;\r\n}\r\n\r\n$result = db_query("SELECT nid FROM legacy WHERE old_id=''$cd''");\r\n$item = db_fetch_array($result);\r\n$nid = "";\r\nif ($item) {\r\n  $nid = $item[''nid''];\r\n}\r\n\r\nheader("Location: $base_url/node/$nid")\r\n?>', '<?php\r\nglobal $base_url;\r\n\r\n$cd = $_REQUEST[''cd''];\r\n\r\nif (!is_numeric($cd)) {\r\n  header("Location: $base_url");\r\n  exit;\r\n}\r\n\r\n$result = db_query("SELECT nid FROM legacy WHERE old_id=''$cd''");\r\n$item = db_fetch_array($result);\r\n$nid = "";\r\nif ($item) {\r\n  $nid = $item[''nid''];\r\n}\r\n\r\nheader("Location: $base_url/node/$nid")\r\n?>', '', 1221602081, 3);


INSERT INTO `node_comment_statistics` (`nid`, `last_comment_timestamp`, `last_comment_name`, `last_comment_uid`, `comment_count`) VALUES ($nid, $time, NULL, 1, 0);


INSERT INTO `history` (`uid`, `nid`, `timestamp`) VALUES (1, 8218, $time);

INSERT INTO url_alias (src, dst, language) VALUES ('node/8218', 'mst/pagina.php', 'pt-br');

