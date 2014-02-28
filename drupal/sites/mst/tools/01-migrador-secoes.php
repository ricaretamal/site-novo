<?php
// DEVE RODAR PRIMEIRO, para que as paginas sejam migradas ja com tid corretos

require("path.conf.php");
require("functions.migracao.php");
require("apiMigratoria.php");
$mysqlCon = connect();


// QUERY DE BUSCA DOS DADOS
mysql_select_db($oldDb);


// SELECT ORIGEM
$sqlTudo = "SELECT
secoes.id as tid, 
secoes.secoes_id as secoes_id,
secoes.secao as name,
secoes.comentarios as description

FROM
tbl_secoes AS secoes";

$resultTudo = mysql_query($sqlTudo);


// INSERE NO BD NOVO
mysql_select_db($newDb);

// LOOP de INSERÇÃO


$increment = 1;

$vidRevistasJornais = array('vid' => 7,
			    'secoes_id' => array(28, 29));

$vidLinks = array('vid' => 8,
		  'secoes_id' => array(13,14,15,16,17,18,19));

$vidGaleria = array('vid' => 4, 
                  'secoes_id' => array(61,66)); 

// exclui termos q nao vao ser usados
$excludeTids = array(1,3,4,6,9,10,11,12,22,23,24,25,26,27,28,29,30,38,41,42,49,58,62,63,64,65,68,69,74,78);

$vidLegado = 1; // vid da taxonomia 'secoes-legado'
while ($item = mysql_fetch_array($resultTudo)) {
    
    // 
    if (in_array($item['tid'],$vidRevistasJornais['secoes_id'])) {
	$item['vid'] = $vidRevistasJornais['vid'];
	
	// secoes de revista / jornal
    } else if (in_array($item['secoes_id'], $vidRevistasJornais['secoes_id'])) {
	$item['vid'] = $vidRevistasJornais['vid'];
	
	// links
    } else if (in_array($item['tid'], $vidLinks['secoes_id'])) {
	$item['vid'] = $vidLinks['vid'];

	// galeria (charges/cartazes)
    } else if (in_array($item['tid'], $vidGaleria)) {
	$item['vid'] = $vidGaleria['vid'];
	
	// resto
    } else {
	$item['vid'] = 4; // assuntos (tags)
    }
 	
	// insert
    if (!in_array($item['tid'], $excludeTids)) {
	insertDrupalTerm($item);	
    }
    
    next($item);
}

// FIM
mysql_close($mysqlCon);

print "$tid secoes importadas." ;
print "migracao OK";
?>
<br/>
<a href='02-migrador-edicoes.php'>Next</a>
