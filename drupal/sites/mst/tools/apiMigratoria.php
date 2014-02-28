<?php
/*********************************************************
 *
 * API migratoria - Irere, ou 'chega-e-vira'
 * Também são conhecidas pelos nomes de apaí, arerê, 
 * assobiadeira, assoviadeira, chega-e-vira, cuchacha,
 * marreca-apaí, marreca-do-pará, marreca-piadeira,
 * marreca-viúva, pato-coral, paturé, paturi, 
 * piadeira e viuvinha
 *
 * http://pt.wikipedia.org/wiki/Dendrocygna_viduata
 *
 *
 * ------------------------------------------------------
 * FUNCOES PARA MIGRAR DRUPAL
 * - versao analpha (muito antes da alpha)
 * 
 * - passe um objeto com esses paramentros a 'api' insere
 * - ainda esta completamente sem testes / checagens
 * 
 * ------------------------------------------------------
 * Isso passarinho mas tambem eh GNU!
 *
 * O que eh GNU? GNU'S NOT UNIX!
 *
 * ------------------------------------------------------
 * fernao@riseup.net  diogo@riseup.net
 *    www.cooperativalaudelina.net 
 *
 ********************************************************/

 /*********************************************************
  *
  *
  ********************************************************/

// includes php functions
require("apiMigratoria.functions.php");

/**
 * Inserts any Drupal Node
 *
 * @param node $array Node
 * @param legacy $bool Bool
 * @return string The product's file name.
 */
function insertDrupalNode($nodeItem, $legacy = true) {
    $debugStr = '';
    
    $title = $nodeItem["title"];
    $type = $nodeItem["type"];
    $nid = $nodeItem["nid"];
    $vid = $nodeItem["vid"];
    $uid = ($nodeItem["uid"]) ? $nodeItem["uid"] : 1;
    $status = ($nodeItem["status"]) ? $nodeItem["status"] : 1;
    $format = ($nodeItem["format"]) ? $nodeItem["format"] : 1; // default - normal
    $entry_date_time = ($nodeItem["entry_date_time"]) ? $nodeItem["entry_date_time"] : time();
    $curr_date_time = ($nodeItem["curr_date_time"]) ? $nodeItem["curr_date_time"] : time();
    $teaser = ($nodeItem["teaser"]) ? $nodeItem["teaser"] : "";
    $body = ($nodeItem["body"]) ? $nodeItem["body"] : "";
    $totalcount = '1';
    $comment = 0;
    $secoes_id = $nodeItem["secoes_id"];
    $oldId = $nodeItem["id"];
    $promote = ($nodeItem['promote']) ? $nodeItem['promote'] : 0;
    $lang = 'pt-br';
    
    // TODO: tirar da node
    if ($legacy) {
	// tabela com relacao dos ids antigos/novos
	$sqlLegacy = "INSERT INTO legacy VALUES ($oldId, $nid, '$type')";
	mysql_query($sqlLegacy);
    }
    // quando nao esta definido um nid, puxar do bd
    if (!isset($nid) || $nid == '') {
	$resLastNid = mysql_query("SELECT MAX(nid) as nid FROM node");
	$lastNidArr = mysql_fetch_assoc($resLastNid);
	$nid = $lastNidArr['nid'] + 1;
    }
    
    // inserção de NODES
    $sqlNode = "
	       INSERT INTO node
	       (nid, type, language, title, uid, status, created, changed, comment, promote, moderate, sticky, vid)
	       VALUES
	       ($nid, '$type', '$lang', '$title', $uid, $status, '$entry_date_time', '$curr_date_time', $comment, $promote, 0, 0, $vid);";
    mysql_query($sqlNode);
    
    $sqlNodeCommentStatistics = "
INSERT INTO node_comment_statistics
(nid, last_comment_timestamp, last_comment_name, last_comment_uid, comment_count)
VALUES
($nid, '$curr_date_time', NULL, $uid, 0);";
    mysql_query($sqlNodeCommentStatistics);
    //print("$sqlNodeCommentStatistics<br/>");
    
    
    $sqlNodeRevisions = "
INSERT INTO node_revisions
(nid, vid, uid, title, body, teaser, timestamp, format, log)
VALUES
($nid, $vid, $uid, '$title', '$body', '$teaser', '$curr_date_time', $format, '');
";
    mysql_query($sqlNodeRevisions);
    //print("$sqlNodeRevisions<br/>");
    
    
    $sqlHistory = "
INSERT INTO history
(uid, nid, timestamp)
VALUES
($uid, $nid, '$curr_date_time')";
    mysql_query($sqlHistory);
    //	    print("$sqlHistory<br/>");
    
    $sqlNodeCounter = "
INSERT INTO node_counter
(nid, totalcount, daycount, timestamp)
VALUES
($nid, $totalcount , 1, '$curr_date_time')";
    mysql_query($sqlNodeCounter);
    //	    print("$sqlNodeCounter<br/>");
    //
    return $nid;
}

function insertDrupalTerm($termItem) {
    
    $tid = $termItem['tid'];
    $vid = $termItem['vid'];
    $name = $termItem['name'];
    
    if (!$vid) return false;
    
    if (isset($termItem['tid'])) {
	$sqlTermData = "INSERT INTO term_data 
(tid, vid, name, description, weight)
VALUES
($tid, $vid, '$name', '', 0)";
    } else {
	$sqlTermData = "INSERT INTO term_data 
(vid, name, description, weight)
VALUES
($vid, '$name', '', 0)";
    }
    
    mysql_query($sqlTermData);
    
    if (!isset($termItem['tid']))
	$tid = mysql_insert_id();
    
    $parentTid = ($termItem['parent']) ? $termItem['parent'] : 0;
    
    $sqlTermHierarchy = "INSERT INTO term_hierarchy
 (tid, parent) 
VALUES ($tid, $parentTid)
";
    mysql_query($sqlTermHierarchy);
    
    return $tid;    
}

function insertDrupalTermNode($termItem) {
    $sqlTermNode = "INSERT INTO term_node 
(nid,vid,tid)
VALUES
(".$termItem['nid'] . ",". $termItem['vid'] .",". $termItem['tid'] . ")";
    mysql_query($sqlTermNode);
    //print("$sqlTermNode<br/>");
}


// sem checagem
function insertDrupalBook($bookItem) {
    
       
    $sqlMenuLinks = "INSERT INTO menu_links (menu_name, plid, link_path, hidden, external, has_children, expanded, weight, module, link_title, options, customized, updated) 
VALUES ('book-toc-". $bookItem['bid'] . "', ". $bookItem['plid'] .", 'node/". $bookItem['nid']  ."', 0, 0, 0, 0, 0, 'book', '". $bookItem['title']  ."', 'a:0:{}', 0, 0)";
    $q3 = mysql_query($sqlMenuLinks);
    //print $sqlMenuLinks;

    
    $sqlUpdateLinks =  "UPDATE menu_links SET router_path = 'node/%', depth = 3, 
p1 = ". $bookItem['p1']  .", p2 = ". $bookItem['p2']  .", p3 = ". $bookItem['mlid']  ." WHERE mlid = ". $bookItem['mlid'] . " ";
    $q4 = mysql_query($sqlUpdateLinks);
    //print $sqlUpdateLinks;
    
    $sqlBook = "INSERT INTO book (nid, mlid, bid) VALUES (". $bookItem['nid'] . ", ". $bookItem['mlid'] . ", ". $bookItem['bid'] . ")";
    $q5 = mysql_query($sqlBook);
    //print $sqlBook;    
    
}


// sem checagem
function insertDrupalImage($imageItem) {
    // adiciona uma imagem no esquema drupal
    // faz todos os inserts e uploads
    
    global $newDb;
    
    mysql_select_db($newDb);
      
    $fid = insertDrupalFiles(array('filename' => $imageItem['filename'], 'filepath' => $imageItem['filepath'], 'syspath' => $imageItem['syspath']));
    if (!$fid) {
	print "nao consegui adicionar " . $imageItem['filepath'];
	//return false;
    }
    
    $imageItem['vid'] = nextId('node','vid'); // revisions value; 
    $imageItem['type'] = 'image'; 
    
    // TODO: tirar o false (pra nao inserir legacy)
    $nid = insertDrupalNode($imageItem, false);
    if (!$nid) return false;
    
    
    // image 
    $image_size = '_original'; // "_original"
    
    $sqlImage = "INSERT INTO image (nid, fid, image_size) VALUES ($nid, $fid, '$image_size')";
    // print $sqlIMage;
    mysql_query($sqlImage);
    
    
    // TODO: futuramente, quando usa pra outros projetos, remover ou melhorar
    
    // tabela com relacao dos ids antigos/novos
    $oldId = $imageItem['old_id'];
    $sqlLegacy = "INSERT INTO legacy VALUES ($oldId, $nid, 'Imagem')";
    
    mysql_query($sqlLegacy);
    
    
    return $nid;
}



// funcao pra inserir 'imagem cck'
function insertDrupalImageCck($imageItem) {
    global $newDb;
    
    mysql_select_db($newDb);
      
    $fid = insertDrupalFiles(array('filename' => $imageItem['filename'], 'filepath' => $imageItem['filepath'], 'syspath' => $imageItem['syspath']));
    if (!$fid) {
	print "nao consegui adicionar " . $imageItem['filepath'];
	//return false;
    }

    // inserir node cck
    $nid = insertDrupalNode($imageItem);
    if (!$nid) print "erro na insercao do node";

    // update dos campos do cck
    
    return $nid;
}


//
function insertDrupalGallery($galleryItem) {
    // vocabulary
    
    if (!isset($galleryItem['vid']) || !isset($galleryItem['name'])) return false;
    
    $tid = insertDrupalTerm($galleryItem);
    
    return $tid;
}

function insertDrupalGalleryImage($galleryItem) {
    // vocabulary

    if (!isset($galleryItem['nid']) || !isset($galleryItem['tid']) || !isset($galleryItem['vid'])) return false;
    $insert = insertDrupalTermNode($galleryItem);
    
    return $insert; // bool    
}


// generalizando pra cck
function updateDrupalCCKFields($fields, $tblName) {
    
    if (!$fields['nid']) return false;
    
    $nid = $fields['nid'];
    
    // remove argumentos que nao sao campos
    unset($fields['nid']);
    $updateFieldsStr = '';
    for ($i = 1; $i <= count($fields); $i++) {
	$key = key($fields);
	$value = $fields[$key];
	
	
	$aspa = (is_string($value)) ? "'" : ''; 
	
	$updateFieldsStr .= "$key = $aspa$value$aspa";
	
	if ($i < count($fields)) {
	    $updateFieldsStr .= ", ";
	}
	
	next($fields);
    }
    
    $sqlImageField = "UPDATE $tblName SET $updateFieldsStr WHERE nid = $nid";
    
    return mysql_query($sqlImageField);
}


// ok
function insertUrlAlias($src, $alias, $lang = 'pt-br') {
    if (!$src || !$alias) return false;
    
    $sql = "INSERT INTO url_alias (src, dst, language) VALUES ('$src', '$alias', '$lang')";
    return mysql_query($sql);
}


function insertComment($itemComment) {
    
    $pid = ($itemComment['pid']) ? $itemComment['pid'] : 0;
    $nid = $itemComment['nid'];
    $uid = $itemComment['uid'];
    $subject = $itemComment['subject'];
    $comment = $itemComment['comment'];
    $hostname = ''; // avoid data retention!
    $timestamp = $itemComment['timestamp'];
    $status = ($itemComment['status']) ? $itemComment['status'] : 0;
    $format = ($itemComment['format']) ? $itemComment['format'] : 1;
    $thread = ($itemComment['thread']) ? $itemComment['thread'] : '01/';
    $name = $itemComment['name'];
    $mail = $itemComment['mail'];
    $homepage = $itemComment['homepage'];
    
    $sql = "INSERT INTO comments (pid,nid,uid,subject,comment,hostname,timestamp,status,format,thread,name,mail,homepage) VALUES ($pid, $nid, uid, '$subject', '$comment', '$hostname', $timestamp, $status, $format, '$thread', '$name', '$mail', '$homepage')";
    
    mysql_query($sql);
}


// ok
// obrigatorio somente o filepath
function createImgAssistHtml($imageArr, $insertType = 'filter') {
    
    if (!$imageArr['filepath']) return false;   
    if (!isset($imageArr['title'])) $imageArr['title'] = '';
    if (!isset($imageArr['body'])) $imageArr['body'] = '';

    $size = getimagesize($imageArr['syspath'] . $imageArr['filepath']);
    $imageArr['width'] = $size[0];
    $imageArr['height'] = $size[1];
    
    // de acordo com o tipo de insert, cria html ou filter
    if ($insertType == 'html') {   
	$html = "<span class='inline inline-left'><img src='/". $imageArr['filepath'] ."' alt='". $imageUrl['title'] ."' title='". $imageArr['title'] ."'  class='image image-_original' /><span class='caption' style='width: " . $imageArr['width'] . " height:" . $imageArr['height'] . ";'><strong>". $imageArr['title'] . " </strong>". $imageArr['body'] ."</span></span>";
	
    } else if ($insertType == 'filter') {
	$html = "[img_assist|nid=" . $imageArr['nid']  . "|title=" . $imageArr['title'] . "|desc=" . $imageArr['body'] . "|link=none" . "|align=left|width=" . $imageArr['width'] . "|height=" . $imageArr['height'] . "] ";
    }

    return $html;
}

/**
 * Inserts any Drupal Node
 *
 * @param node $array Node
 * @return string The product's file name.
 */
function insertDrupalFiles($fileArr) {
    
    global $newDb;
    
    mysql_select_db($newDb);
    if (!$fileArr['filename'] || !$fileArr['filepath'] || !$fileArr['syspath']) return false;
    
    // default
    $uid = 1;
    $fid = nextId('files', 'fid');
    
    $filename = $fileArr['filename']; // "_original"
    $filepath = $fileArr['filepath'];  // caminho definitivo c/ filename
    $syspath = $fileArr['syspath'];
    
    $file = $syspath . $filepath;
    if (file_exists($file)) {
	$filesize = filesize($file);	
	$filemime =  mime_content_type($file);
    } else {
	print "arquivo '$file' nao existe";
    }
    
    $status = 1; // 0 para nao publicado e 1 para publicado 
    $timestamp = time();// unix time stamp;
    
    $sqlFile = "INSERT INTO files (uid, filename, filepath, filemime, filesize, status, timestamp) VALUES ($uid, '$filename', '$filepath', '$filemime', $filesize, $status, $timestamp)";
    
    if (mysql_query($sqlFile))
	return $fid;
}


// nao eh usada se usar cck, vou manter pois pode servir futuramente
function imageAttach($node, $image){
    
    $imageId = $image['nid'];
    $nodeId = $node['nid'];
    
    if (!$nodeId || !$imageID) return false;
    
    $sqlImgAttach = "INSERT INTO image_attach VALUES ($nodeId, $imageId)";
    mysql_query($sqlImgAttach);
}


// essa funcao anexa um conteudo a um node
function attachToNode($node, $file) {
    
    $fid = insertDrupalFiles(array('filename' => $file['filename'], 'filepath' => $file['filepath'], 'syspath' => $file['syspath']));
    if (!$fid) {
	print "nao consegui adicionar " . $imageItem['filepath'];
	//return false;
    }
    
    $nid = $node['nid'];
    $vid = $node['vid'];
    $list = ($node['list']) ? $node['list'] : 1;
    $weight = ($node['weight']) ? $node['weight'] : 0;
    $description = $file['filename'];
    
    $sqlUpload = "INSERT INTO upload (fid, nid, vid, list, description, weight) VALUES ($fid, $nid, $vid, $list, '$description', $weight)";
    mysql_query($sqlUpload);
}


?>
