<?php
/****

 Script para migrar imagens no meio das materias

*/

require("path.conf.php");
require("functions.migracao.php");
require("apiMigratoria.php");

$mysqlCon = connect();


/********************
     FUNCTIONS
********************/

function migrateImageList($type) {
    
    global $oldDb;
    global $newDb;
    
    // inclui paths de caminhos
    global $filepathDir;
    global $syspath;
    global $filepathDirOldCapa;
    global $filepathDirOldGaleria;
    global $filepathDirOldAnexadas;
    
    
    switch($type) {
    
    case 'story':
	$sqlStory = "select id as old_id, concat(id, '.',foto) as filename, titulo, texto, credito from tbl_paginas where foto != '' AND edicoes_id = 0";
	
	mysql_select_db($oldDb);

	$resource = mysql_query($sqlStory); 

	while ($imageItem = mysql_fetch_assoc($resource)) {
	    
	    // inserir nova imagem
	    $imageItem['filepath'] = $filepathDir . $imageItem['filename'];
	    
	    // set file
	    $oldFile = $filepathDirOldAnexadas . $imageItem['filename'];
	    $newFile = $syspath . $filepathDir . $imageItem['filename'];
	    
	    //$nid = nextId('node','nid'); // Pega um nid antes de tentar inserir.    
	    //$imageItem['nid'] = $nid;
	    $imageItem['body'] = $imageItem['credito'];
	    $imageItem['filename'] = "_original";
	    $imageItem['title'] = $imageItem['titulo'];
	    $imageItem['syspath'] = $syspath;	    
	    
	    // copia imagens
	    if (file_exists($oldFile) && !file_exists($newFile)) {
		$copia = copy($oldFile, $newFile);
		if (!$copia) {
		    print "Erro copiando ($oldFile) para ($newFile)";
		    exit();
		} else {
		    print "Anexado $oldFile copiada. <br/> ";
		}
	    }

	    // -----
	    // insere imagem do cck
	    // -----
	    
	    $fid = insertDrupalFiles(array('filename' => $imageItem['filename'], 'filepath' => $imageItem['filepath'], 'syspath' => $imageItem['syspath']));	    
	    
	    // pegar nid novo na tabela legacy
	    mysql_select_db($newDb);
	    $sqlLegacy = "SELECT * FROM legacy WHERE old_id = '". $imageItem['old_id'] . "'";
	    $resLegacy = mysql_query($sqlLegacy);
	    $node = mysql_fetch_assoc($resLegacy);
	    
	    $fields = array('field_foto_fid' => $fid,
			    'nid' => $node['nid'],
			    'field_foto_data' => "a:0:{}", // default
			    'field_foto_list' => 1 // default
			    );
	    
	    updateDrupalCCKFields($fields, 'content_type_story');
	    /*
	    if ($imageItem['old_id'] == 2911) {
		print_r($imageItem);
		print "<hr>";
		print $oldFile;
		print $newFile;
		exit();
	    }
	    */
	}

	break;

    case 'book':
	// imagens anexadas ### (id da mesma materia, indicado pelo preenchimento do campo 'foto',
	$sqlImgAnexas = "select id as old_id, concat(id, '.',foto) as filename, titulo, texto, credito from tbl_paginas where foto != '' AND edicoes_id !=0";
	//   -> inserir o node imagem
	//   -> inserir um image_assist padrao
	mysql_select_db($oldDb);

	$resImagem = mysql_query($sqlImgAnexas); 
	
	
	while($imageItem = mysql_fetch_assoc($resImagem)) {


	    $imageItem['filepath'] = $filepathDir . $imageItem['filename'];
	    // set files
	    $oldFile = $filepathDirOldAnexadas . $imageItem['filename'];
	    $newFile = $syspath . $filepathDir . $imageItem['filename'];

	    $nid = nextId('node','nid'); // Pega um nid antes de tentar inserir.
	    
	    $imageItem['nid'] = $nid;
	    $imageItem['vid'] = nextId('node_revisions','vid'); // revisions value
	    // pensar como eh melhor montar o objeto do novo item (image)
	    $imageItem['body'] = $imageItem['texto'] . $imageItem['credito'];
	    $imageItem['filename'] = "_original";
	    $imageItem['title'] = $imageItem['titulo'];
	    $imageItem['syspath'] = $syspath;
	  
	    // copia imagens
	    if (file_exists($oldFile) && !file_exists($newFile)) {
		$copia = copy($oldFile, $newFile);
		if (!$copia) {
		    print "Erro copiando ($oldFile) para ($newFile)";
		    exit();
		} else {
		    print "Anexo $oldFile copiado. <br/> ";
		}
	    }
	
	    insertDrupalImage($imageItem);
	    
   	    // pega o pedaco de html do img_assist
	    
	    $htmlImgAssist = createImgAssistHtml($imageItem, 'filter');
	    
	    // pega o nid da materia
	    $sqlLegacy = "SELECT nid from legacy where old_id = '". $imageItem['old_id'] ."' AND type = 'story'";

	    $resLegacy = mysql_query($sqlLegacy);
	    //print $sqlLegacy;
	    
	    $resultLegacy = mysql_fetch_row($resLegacy);
	    
	    // pegar o nid da materia associada p/ fazer update
	    $nodeItem = array('nid' => $resultLegacy[0], 
		      'body' => $htmlImgAssist . $imageItem['texto']);
	    
	    // insere na tabela imgAssist (usado para rebuild derivative ?)
	    $sqlImgAssist = "INSERT INTO img_assist_map VALUES (". $nodeItem['nid']  .", ". $imageItem['nid'] .")";
	    $resImgAssist = mysql_query($sqlImgAssist);
	    
	    $update = updateNode($nodeItem);
	    
	    next($imageItem);
	}


	break;
	
	
    case 'capa':

	// pegar as capas que existem de cada edicao (id antigo)
	mysql_select_db($oldDb);
	
	$sql = "SELECT id as old_id, concat(id, '.',capa) as filename FROM tbl_edicoes";
	$resource = mysql_query($sql);
	
	$arrCapas = array();
	while ($imageItem = mysql_fetch_assoc($resource)) {
	    
	    // inserir nova imagem
	    $imageItem['filepath'] = $filepathDir . $imageItem['filename'];
	    
	    // set file
	    $oldFile = $filepathDirOldCapa . $imageItem['filename'];
	    $newFile = $syspath . $filepathDir . $imageItem['filename'];
	    
	    //$nid = nextId('node','nid'); // Pega um nid antes de tentar inserir.    
	    //$imageItem['nid'] = $nid;
	    $imageItem['body'] = $imageItem['credito'];
	    $imageItem['filename'] = "_original";
	    $imageItem['title'] = $imageItem['titulo'];
	    $imageItem['syspath'] = $syspath;	    
	     
	    // copia imagens
	    if (file_exists($oldFile) && !file_exists($newFile)) {
		$copia = copy($oldFile, $newFile);
		if (!$copia) {
		    print "Erro copiando ($oldFile) para ($newFile)";
		    exit();
		} else {
		    print "Capa $oldFile copiada. <br/> ";
		}
	    }

	    // -----
	    // insere imagem do cck
	    // -----
	    
	    $fid = insertDrupalFiles(array('filename' => $imageItem['filename'], 'filepath' => $imageItem['filepath'], 'syspath' => $imageItem['syspath']));	    
	    
	    // pegar nid novo na tabela legacy
	    mysql_select_db($newDb);
	    $sqlLegacy = "SELECT * FROM legacy WHERE old_id = '". $imageItem['old_id'] . "'";
	    $resLegacy = mysql_query($sqlLegacy);
	    $node = mysql_fetch_assoc($resLegacy);
	    
	    $fields = array('field_capa_fid' => $fid,
			    'nid' => $node['nid'],
			    'field_capa_data' => "a:0:{}", // default
			    'field_capa_list' => 1 // default
			    );
	    
	    updateDrupalCCKFields($fields, 'content_type_book');
	    
	  }

	
	break;
    
    case 'interno':
	
	// imagens no meio ###
	$sqlImgDentro = "select id,titulo,texto from tbl_paginas where texto like '%jpg%'";
	//     -> subir imagens por mass import
	//     -> string replace

	$resource =  mysql_query($sqlImgDentro);
	while($imageItem = mysql_fetch_assoc($resource)) {
	    $imageList[] = $imageItem;
	}


	break;
	
	
    case 'galeria':
	
	// galeria de imagens
	
	
	mysql_select_db($oldDb);
	
	// default
	$vid = 2;

	$sqlGalerias = "SELECT DISTINCT pf.paginas_id, p.titulo AS name from tbl_paginas_fotos pf, tbl_paginas p WHERE pf.paginas_id = p.id AND pf.foto !=''";
	
	$resGalerias =  mysql_query($sqlGalerias);
	
	// - inserir as galerias => term_data
	while ($galeria = mysql_fetch_assoc($resGalerias)) {
	    
	    mysql_select_db($newDb);
	    $galleryItem = array('vid' => $vid,
				 'name' => $galeria['name']); // puxar o nome de onde ?
	    $tid = insertDrupalGallery($galleryItem);
	    
	    /* OBS: usar caso associe com paginas
	    // pegar nid novo na tabela legacy
	    mysql_select_db($newDb);
	    $sqlLegacy = "SELECT nid FROM legacy WHERE old_id = '". $galeria['paginas_id'] . "'";
	    $resLegacy = mysql_query($sqlLegacy);
	    $resultLegacy = mysql_fetch_assoc($resLegacy);
	    $nidPagina = $resultLegacy['nid'];
	    */
	    // parei aqui
	    // inserir imagens de cada galeria
	    mysql_select_db($oldDb);
	    $sqlImagensGaleria = "SELECT pf.id, pf.paginas_id, pf.ordem, pf.legenda, pf.credito, pf.foto, UNIX_TIMESTAMP(p.atualizacao) as curr_date_time FROM tbl_paginas_fotos pf, tbl_paginas p WHERE pf.paginas_id = p.id AND pf.foto !='' AND pf.paginas_id = '" . $galeria['paginas_id'] . "'";
	    //print $sqlImagensGaleria;
	    
	    $resImagensGaleria =  mysql_query($sqlImagensGaleria);
	    
	    while($imageItem = mysql_fetch_assoc($resImagensGaleria)) {
		// reseta o nid
		$nid = '';
		
		// define arquivo
		$compl = ($imageItem['ordem'] < 10) ? "0" : "";
		$filename = $imageItem['paginas_id'] . "_" . $compl . $imageItem['ordem'] . "." . $imageItem['foto'];
		$imageItem['filepath'] = $filepathDir . $filename;
		
		// set file
		$oldFile = $filepathDirOldGaleria . $filename;
		$newFile = $syspath . $filepathDir . $filename;
		
		// copia imagens
		if (file_exists($oldFile) && !file_exists($newFile)) {
		    $copia = copy($oldFile, $newFile);
		    if (!$copia) {
			print "Erro copiando ($oldFile) para ($newFile)";
			exit();
		    } else {
		    print "Capa $oldFile copiada. <br/> ";
		    }
		}
		
		// set the array
		$imageItem['body'] = $imageItem['credito'];
		$imageItem['entry_date_time'] = $imageItem['curr_date_time'];
		$imageItem['curr_date_time'] = $imageItem['curr_date_time'];
		$imageItem['filename'] = "_original";
		$imageItem['title'] = $imagem['legenda'];
		$imageItem['syspath'] = $syspath;	    
		
		// ta dando pau aqui eu acho - verificar 
		// cria o node
		$nid = insertDrupalImage($imageItem, false);
		
		// associa com galeria
		$imageItem['nid'] = $nid;
		$imageItem['vid'] = $nid;
		$imageItem['tid'] = $tid;
		insertDrupalGalleryImage($imageItem);
		
		// associa ? com pagina - nao sei como fazer ainda
	    }
	}
	
	break;
    }  
    
}


// especifica
function updateNode($itemNode) {

    global $newDb;

    mysql_select_db($newDb);
    
    $sqlUpdate = "UPDATE node_revisions SET body=\"". $itemNode['body'] ."\", format = 1 WHERE nid = ". $itemNode['nid']  ."";
    
    $query = mysql_query($sqlUpdate);
    return $query;
}




// cck - especifica
function updateImageField($fields) {
    
    $capa_data = "a:0:{}";
    $capa_list = 1;
    $capa_fid = $fields['capa_fid'];
    $nid = $fields['nid'];
    
    if (!$capa_fid || !$nid) return false;
    
    $sqlImageField = "UPDATE content_type_book SET field_capa_fid = $capa_fid, field_capa_data = '$capa_data', field_capa_list = $capa_list WHERE nid = $nid";
    
    return mysql_query($sqlImageField);
}


migrateImageList('story');
migrateImageList('book');
migrateImageList('capa');
migrateImageList('galeria');

mysql_close($mysqlCon);


?>
