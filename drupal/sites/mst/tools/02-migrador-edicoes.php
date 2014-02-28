<?php

require("functions.migracao.php");
require("apiMigratoria.php");
$mysqlCon = connect();


// DEVE RODAR PRIMEIRO, para que as paginas sejam migradas ja com tid corretos


// QUERY DE BUSCA DOS DADOS
mysql_select_db($oldDb);


// TODO: migrar TODAS as materias, nao somente as que vao virar book
function migraMaterias($migrationType, $arrMapMaterias) {
   
   // a partir de um valor de edicoes_id,
    // - loop por todas as materias com esse edicoes_id
    // - inserir uma a uma
    global $oldDb;
    global $newDb;
    
    foreach ($arrMapMaterias as $mapMateria) {
	
	switch ($migrationType) {    
	    
	case 'edicoes':
	    
	    $oldEdicoesId = $mapMateria['edicoes_id'];
	    $newEdicoesId = $mapMateria['nid'];
	    $bid = $mapMateria['bid'];
	    $plid = $mapMateria['plid'];
	    $p1 = $mapMateria['p1'];
	    $p2 = $mapMateria['p2'];
	    $numeroEdicao = $mapMateria['numero_edicao'];
	    $tipoEdicao = $mapMateria['tipo_edicao'];
	    $nidEdicao = $mapMateria['nid_edicao'];
	    	    
	    mysql_select_db($oldDb);
	    // SELECT ORIGEM

	    $sql = "SELECT
paginas.id as id, 
paginas.titulo as title,
paginas.texto as body, 
UNIX_TIMESTAMP(paginas.atualizacao) as entry_date_time,
UNIX_TIMESTAMP(paginas.atualizacao) as curr_date_time,
paginas.exibir as status,
paginas.contador as totalcount,
paginas.secoes_id as secoes_id,
paginas.edicoes_id as edicoes_id,
paginas.destaque_especial as destaque

FROM
tbl_paginas AS paginas WHERE edicoes_id = $oldEdicoesId 
AND exibir = 1";

	    $type = 'book';
	    
	    break;

	    
	case 'materias':
	    
	    mysql_select_db($oldDb);
	    $sql = "SELECT
paginas.id as id, 
paginas.titulo as title,
paginas.texto as body, 
UNIX_TIMESTAMP(paginas.atualizacao) as entry_date_time,
UNIX_TIMESTAMP(paginas.atualizacao) as curr_date_time,
paginas.exibir as status,
paginas.contador as totalcount,
paginas.secoes_id as secoes_id,
paginas.edicoes_id as edicoes_id

FROM
tbl_paginas AS paginas WHERE edicoes_id = 0";

	    $type = 'story';

	    break;
	    
	    
	case 'links':

	    mysql_select_db($oldDb);
	    $sql = "SELECT 
paginas.id as id,
paginas.titulo as title,
paginas.link as url,
paginas.texto as body,
UNIX_TIMESTAMP(paginas.atualizacao) as entry_date_time,
UNIX_TIMESTAMP(paginas.atualizacao) as curr_date_time,
paginas.secoes_id as secoes_id

FROM tbl_paginas AS paginas
WHERE edicoes_id = 0 
AND secoes_id in (13,14,15,16,17,18,19)";
	    $type = 'links';
	    
	    break;

	}
	
	
	$resultMateria = mysql_query($sql);
	//print $sql;
	//
	
	// definicao de vars constantes
	$format = 1;
	$uid = 1;	
	
	updateMenuLinks(array('mlid' => $p2));
	

	// LOOP de INSERÇÃO
	while ($itemMateria = mysql_fetch_assoc($resultMateria)) {
	    
	    $skipThis = false;
	    
	    $itemMateria['nid'] = nextId('node','nid');
	    $itemMateria['vid'] = nextId('node_revisions','vid'); // revisions value
	    $itemMateria['type'] = $type;
	    $itemMateria['uid'] = $uid;
	    $itemMateria['format'] = ($format) ? $format : 1;
	    
	    $itemMateria['promote'] = ($migrationType == 'edicoes') ? 0 : 1;
	    
	    // pequeno fix para datas vazias ... :/
	    
	    if ($itemMateria['entry_date_time'] == 0) {
		$itemMateria['entry_date_time'] = getLastGoodDate(array('id' => $itemMateria['id']));
	    }
	    if ($itemMateria['curr_date_time'] == 0) {
		$itemMateria['curr_date_time'] = getLastGoodDate(array('id' => $itemMateria['id']));
	    }
	    
	    // unifica destaque
	    if (($itemMateria['secoes_id'] == 63 && $itemMateria['destaque'] == 1) || ($itemMateria['secoes_id'] == 42)) {
		$itemMateria['tid'] = 32;
	    // unifica editorial
	    } else if ($itemMateria['secoes_id'] == 41) {
	        $itemMateria['tid'] = 33;
	    // unifica expediente
	    } else if ($itemMateria['secoes_id'] == 49) {
	        $itemMateria['tid'] = 37;

            // INICIO DA MIGRACAO DE SECOES VID=3
	    } else if ($itemMateria['secoes_id'] == 4) {
		// define como artigo
		$itemMateria['tid'] = 80;
	    } else if ($itemMateria['secoes_id'] == 6) {
		// define como entrevista
		$itemMateria['tid'] = 81;
	    } else if ($itemMateria['secoes_id'] == 9) {
		// define como dados
		$itemMateria['tid'] = 79;
	    } else if ($itemMateria['secoes_id'] == 64) {
		// define como documentos
		$itemMateria['tid'] = 85;
	    } else if ($itemMateria['secoes_id'] == 7) {
		// define como livros
		$itemMateria['tid'] = 82;
		// FIM DA MIGRACAO DE SECOES VID=3
		
		// FIX de BD 
	    } else if ($itemMateria['secoes_id'] == 28) {
		// - materias que estao linkadas com jornais
		$itemMateria['tid'] = fixDB_edicoes($itemMateria['id']);
		if (!$itemMateria['tid']) {
		    $skipThis = true;
		}
	    } else if ($itemMateria['secoes_id'] == 29) {
		// - materias que estao linkadas com revistas
		$itemMateria['tid'] = fixDB_edicoes($itemMateria['id']);
		if (!$itemMateria['tid']) {
		    $skipThis = true;
		}

	    } else {
		$itemMateria['tid'] = $itemMateria['secoes_id'];
	    }

	    // comum a todas as materias
	    mysql_select_db($newDb);

	    if (!$skipThis) {
		insertDrupalNode($itemMateria, true);
		insertDrupalTermNode($itemMateria);
		
		
		// se tiver edicoes
		if ($migrationType == 'edicoes') {
		    
		    $itemMateria['mlid'] = nextId('menu_links','mlid');
		    $itemMateria['p1'] = $p1;
		    $itemMateria['p2'] = $p2;
		    $itemMateria['p3'] = $p3;
		    $itemMateria['bid'] = $bid;
		    $itemMateria['plid'] = $plid;
		    
		    insertDrupalBook($itemMateria);
		    
		    // adiciona url_alias na mesma revista
		    
		    // sql para pegar o nome do termo
		    
		    mysql_select_db($newDb);
		    $sqlTerm = "SELECT td.name FROM term_data td, term_node tn WHERE tn.tid = td.tid AND tn.tid NOT IN (28,29,63) AND tn.nid = " . $itemMateria['nid'];
		    $resSqlTerm = mysql_query($sqlTerm);
		    $itemTerm = mysql_fetch_array($resSqlTerm);
		    $termName = strtolower($itemTerm['name']);
		    
		    global $arrUrlAlias;
		    $src = "node/". $itemMateria['nid'];
		    $alias = $arrUrlAlias[$tipoEdicao] . "/" . $numeroEdicao . "/$termName";
		    
		    insertUrlAlias($src, $alias);
		}
	    }
		
	    if ($migrationType == 'links') {
		// inserir no 
		
		$vid = $itemMateria['vid'];
		$nid = $itemMateria['nid'];
		$url = $itemMateria['url'];
		mysql_select_db($newDb);		
		$sqlCCK = "INSERT INTO content_type_links (vid, nid, field_url_url)
 VALUES
 ($vid, $nid, '$url')";
		
		mysql_query($sqlCCK);

	    }

	    if ($migrationType == 'materias') {
		
		$vid = $itemMateria['vid'];
		$nid = $itemMateria['nid'];
		
		mysql_select_db($newDb);		
		$sqlCCK = "INSERT INTO content_type_story (vid, nid)
 VALUES
 ($vid, $nid)";
		
		mysql_query($sqlCCK);

	    }
	    
	    next($itemMateria);
	}
    }

}  /// function migrarMaterias


// funcao para migrar os conteudos anexados
function migraArquivosAnexados() {
    
    global $oldDb,$newDb,$filepathDir,$syspath,$filepathDirAnexados;
    mysql_select_db($oldDb); 
/*  
    $filepathDir = "sites/default/files/";
    $syspath = "/var/www/www/mst.org.br/release/";
    $filepathDirAnexados = "/var/www/www/mst_antigo/mst/documentos/";
*/
    
    $sql = "SELECT id,texto FROM tbl_paginas WHERE texto LIKE '%/mst/documentos%.pdf%' OR texto LIKE '%/mst/documentos%.doc%' OR texto LIKE '%/mst/documentos%.jpg%'";
    $resSql = mysql_query($sql);
    
    while ($itemArquivo = mysql_fetch_array($resSql)) {
	
	$file = array();
	
	preg_match('/(.+)http:\/\/www\.mst\.org\.br\/mst\/documentos\/(.+)\.([A-Za-z]{3,4})(.+)/',
		   $itemArquivo['texto'],
		   $matches
		   );

	// pegou o arquivo - no formato:   nomedoarquivo.{doc,pdf}
	$file['filename'] = $matches[2] . "." . $matches[3];
	$file['filepath'] = $filepathDir . $file['filename'];
	$file['syspath'] = $syspath; // mudar esse dir em cada instalacao
	
	// tenta copiar a partir da origem
	$origFile = $filepathDirAnexados . $file['filename'];
	$destFile = $file['syspath'] . $filepathDir . $file['filename'];
	
	if (!copy("$origFile", "$destFile")) {
	    print "erro ao copiar($origFile, $destFile)!";
	    return false;
	}
	
	// pega o node do legacy
	mysql_select_db($newDb);
	$sqlLegacy = "SELECT nid from legacy where old_id = '". $itemArquivo['id'] ."' AND type = 'story'";
	$resLegacy = mysql_query($sqlLegacy);
	$resultLegacy = mysql_fetch_row($resLegacy);
	
	// pegar o nid da materia associada p/ fazer update
	$node = array('nid' => $resultLegacy[0],
		      'vid' => $resultLegacy[0]);
	
	attachToNode($node, $file);
	
	next($itemArquivo);
    }

    
}


// especifica
function updateMenuLinks($menuLinksItem) {
    
    global $newDb;
    mysql_select_db($newDb);
    $sqlUpdateHasChildren = "UPDATE menu_links SET has_children = 1 WHERE mlid = ". $menuLinksItem['mlid'] . " ";
    mysql_query($sqlUpdateHasChildren);
    //print "has child: $sqlUpdateHasChildren<br/>";
}


function updateEmbededNodes() {
    global $newDb;
    mysql_select_db($newDb);
    // altera os conteudos embedados para Full HTML
    $sqlUpdateEmbededNodes = "UPDATE node_revisions SET format = 2 WHERE body like '%embed%'";
    mysql_query($sqlUpdateEmbededNodes);
    
}


/*
 * Funcao de fix item a item
 */
function fixDB_edicoes($id) {
    switch($id) {
    case '4609':
	$secoes_id = false;
	break;
    case '5087':
	$secoes_id = false;
	break;
    case '1982':
	$secoes_id = 37;
	break;
    case '1989':
	$secoes_id = 34;
    case '2009':
	$secoes_id = false;
	break;
    }

    return $secoes_id;
}


function fixTitle($edicoes_id, $tipoEdicao) {
    global $oldDb;
    mysql_select_db($oldDb);
    
    if ($tipoEdicao == "Jornal Sem Terra") {
	$secoes_id = 42;
    } else if ($tipoEdicao == "Revista Sem Terra") {
	$secoes_id = 32;
    } else if ($tipoEdicao == "Especial") {
	
    }
    
    return mysql_result(mysql_query("SELECT titulo FROM tbl_paginas WHERE edicoes_id = $edicoes_id AND secoes_id = $secoes_id"),0);
}


// espeficica
//
// essa funcao surgiu pra fazer o seguinte:
// - caso existam datas invalidas (tem + 300 registros assim no bd antigo) 
//   - tentar pegar pela data dos ids mais antigos, recursivamente, ate conseguir
function getLastGoodDate($item) {
    
    global $oldDb;
    mysql_select_db($oldDb);
    
    $idTry = $item['id'] - 1;
    ///    print $idTry;
    
    $sqlTry = "SELECT atualizacao FROM tbl_paginas WHERE id = $idTry";  
    $resTry = mysql_query($sqlTry);
    
    $data = mysql_fetch_array($resTry);
    // chamada recursiva ate a data + proxima valida
    while (!isset($data['atualizacao']) || $data['atualizacao'] == '0000-00-00 00:00:00') {
	$item['id'] -= 1;
	$data['atualizacao'] = getLastGoodDate($item);
    }    
    return $data['atualizacao'];
}

/*****************************************

     COMEÇA A IMPORTACAO DE EDICOES


*****************************************/



// UPDATE dos PAIS
$parentsMlid = array(168,169,170);

for ($i = 0; $i < count($parentsMlid); $i++) {
    updateMenuLinks(array('mlid' => $i));
}



// SELECT ORIGEM
$sqlTudo = "SELECT
edicoes.id as edicoes_id, 
edicoes.secoes_id as secoes_id,
edicoes.titulo as title,
edicoes.numero as numero,
edicoes.meses as meses,
edicoes.ano as ano,
edicoes.destaque as body,
secoes.secao as tipoEdicao

FROM
tbl_edicoes AS edicoes,
tbl_secoes as secoes

WHERE edicoes.secoes_id = secoes.id
AND edicoes.capa != ''
ORDER BY secoes_id,numero";


// TODO: migrar dados de numero, mes e ano para esquema melhor
mysql_select_db($oldDb);
$resultTudo = mysql_query($sqlTudo);


/******************************
 - definicao de constantes - 

******************************/

// PLID - (parent id)
// id do menu pai

// pega o max_id de menu_links
mysql_select_db($newDb);

$plidArr = array();
$plidArr['Jornal Sem Terra'] = 168;
$plidArr['Revista Sem Terra'] = 169;
$plidArr['Especiais'] = 170;


// BID - book id parent
$bidArr = array();
$bidArr['Jornal Sem Terra'] = 1;
$bidArr['Revista Sem Terra'] = 2;
$bidArr['Especiais'] = 3;


// NID - (node id) 
// deve mudar caso mude a
// ordem dos nodes importados
$vidRes = mysql_query("SELECT MAX(nid) as max FROM node");
$vidArr = mysql_fetch_row($vidRes);
$vid = $vidArr[0];
$nid = $vidArr[0];

// UID - (user id)
$uid = 1;


// MLID - (menu_links id)
$mlidRes = mysql_query("SELECT MAX(mlid) as max FROM menu_links");
$mlidRes = mysql_fetch_row($mlidRes);
$mlid = $mlidRes[0];

foreach ($plidArr as $qq) {
    $sqlplidArr = mysql_query("update menu_links set has_children = 1 where mlid=$qq");
    //print "update do has_children: $qq<br/>";
}


$arrMapEdicoes = array();

$arrUrlAlias = array();
$arrUrlAlias['Jornal Sem Terra'] = 'jornal';
$arrUrlAlias['Revista Sem Terra'] = 'revista';
$arrUrlAlias['Especiais'] = 'especiais';


// criar array pra tipo de book-toc-$x

/*************************************
               - loop -

 pega cada registro de tbl_edicoes e
 cria um book no esquema de edicoes

*************************************/
$weight = 0;
while ($item = mysql_fetch_array($resultTudo)) {
    
    $tipoEdicao = $item["tipoEdicao"];

    $secoes_id = $item["secoes_id"];
    $edicoes_id = $item["edicoes_id"];
    $body = '';
    
    $nid = nextId('node', 'nid');
    $mlid = nextId('menu_links', 'mlid');
    $revisions_value = $nid;
    $entry_date_time = time();
    $curr_date_time = time();
    //    $teaser_value = $item["body"];
    $totalcount = '1';
    $plid = $plidArr[$tipoEdicao];
    $bid = $bidArr[$tipoEdicao];
    $numero = $item["numero"];
    $meses = $item["meses"];
    $ano = $item["ano"];
    $weight -= 1;
    
    $title = $item["title"];
    
    if ($title == '') {
	$title = fixTitle($item["edicoes_id"], $tipoEdicao);
    }

    //   print("<b>inserindo $tipoEdicao, $title, $mlid</b><br/>");
    
    /***
	inserção de BOOKS
	- node_revisions
	- node
	- menu_links
	- book
	- node_comment_statistics
    ***/
    
    mysql_select_db($newDb);
    $sqlLegacy = "INSERT INTO legacy VALUES ($edicoes_id, $nid, '$tipoEdicao')";
    $q1 = mysql_query($sqlLegacy);

    $sqlNodeRevisions = "INSERT INTO node_revisions (nid, uid, title, body, teaser, log, timestamp, format) VALUES ($nid, $uid, '$title', '$body', '', '', $entry_date_time, 1)";
    $q1 = mysql_query($sqlNodeRevisions);
    
    

    $vidRes = mysql_query("SELECT LAST_INSERT_ID()");
    $vidRes = mysql_fetch_row($vidRes);
    $vid = $vidRes[0];

    $sqlNode = "INSERT INTO node (vid, type, language, title, uid, status, created, changed, comment, promote, moderate, sticky, tnid, translate) VALUES ($vid, 'book', 'pt-br', '$title', $uid, 1, $entry_date_time, $curr_date_time, 0, 0, 0, 0, 0, 0)";
    $q2 = mysql_query($sqlNode);


    
    $sqlMenuLinks = "INSERT INTO menu_links (
       mlid,menu_name, plid, link_path, hidden, external, has_children, expanded, weight, module, link_title, options, customized, updated) 
VALUES ('$mlid', 'book-toc-$bid', $plid, 'node/$nid', 0, 0, 1, 0, '$weight','book', '$title', 'a:0:{}', 0, 0)";
    $q3 = mysql_query($sqlMenuLinks);
    $sqlUpdateLinks =  "UPDATE menu_links SET router_path = 'node/%', depth = 2, p1 = $plid, p2 = $mlid WHERE mlid = '$mlid'";
    $q4 = mysql_query($sqlUpdateLinks);

    $sqlBook = "INSERT INTO book (nid, mlid, bid) VALUES ($nid, $mlid, $bid)";
    $q5 = mysql_query($sqlBook);

    
    // url alias
    $src = "node/$nid";
    $alias = $arrUrlAlias[$tipoEdicao] . "/" . $numero ;
    insertUrlAlias($src, $alias);
    
    
    // TODO-cck: 
    // insere dados do cck
    
    $arrMes = split('/', $meses);
    
    if ($arrMes[0] == $arrMes[1]) {
	$meses = $arrMes[0];
    }
    
    $field_capa_list = NULL;
    $field_capa_data = NULL;
    $sqlCCK = "INSERT INTO content_type_book (vid, nid, field_numero_value, field_ano_value, field_mes_value)
 VALUES
 ($vid, $nid, $numero, $ano, '$meses')";
    $qCCK = mysql_query($sqlCCK);
    
    
    
    // inserção de NODES    
    // devido a alteracao de nid, eh melhor fazer a migracao da materia 
    // aqui e nao num arquivo separado
    // vai ficar pesado mas eh o jeito
    
    
    /*
     gravar um array com o mapa dos valores de cada edicao (antigo,novo,bid)
    */
    
    //    print $plid; exit();
    $arrMapEdicoes[] = array("edicoes_id" => $edicoes_id, "nid" => $nid, "bid" => $bid, "p1" => $plid, "p2" => $mlid, "plid" => $mlid, "numero_edicao" => $numero, "tipo_edicao" => $tipoEdicao, "nid_edicao" => $nid);
    
    next($item);
	
}   // fim do while $item = mysql_fetch_array($resultTudo)

//print_r($arrMapEdicoes);


migraMaterias('edicoes', $arrMapEdicoes);
migraMaterias('materias', array("materias" => 1));
migraMaterias('links', array("links" => 1));
migraArquivosAnexados();
updateEmbededNodes();


// FIM
mysql_close($mysqlCon);

print "$tid edicoes importadas." ;
print "migracao OK";
?>
<br/>
 <a href='03-migrador-imagens.php'>Next</a> 
