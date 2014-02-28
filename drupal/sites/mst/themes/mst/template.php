<?php
// $Id: template.php,v 1.16 2007/10/11 09:51:29 goba Exp $

/***********************************
 *    -----------------------
 *    | TAXONOMY PREPROCESS |
 *    -----------------------
 *
 *   Serve para criar variaveis que nao estao disponiveis 
 *   normalmente nas paginas taxonomy/*
 * 
 *
 *  ## Conteudo ##
 * 
 *  1. Cria variaveis para navegacao interna pelas categorias 
 *  do arquivo, com filtragem por tipo e layout proprio.
 *
 ***********************************/
function taxonomy_preprocess(&$variables, $type) {

    //---------
    //   1. Cria navegacao interna do arquivo
    //---------

 
    // get term id -> poor way :(
    
    if ($type == 'page') {
	$strTid = $variables['template_files'][2];
	$tids = array();
	
	$itensTid = explode('-', $strTid);

	foreach ($itensTid as $item) {
	    if (is_numeric($item)) {
		$tids[] = $item;
	    } else if (stripos($item, ',')){
		$itemList = explode(',', $item);
		foreach ($itemList as $itemL) {
		    if (is_numeric($itemL))
			$tids[] = $itemL;
		}
	    }
	}
    }
    

    if ($tids) {
	// get vocabulary id
	$resultVid = db_query(db_rewrite_sql('SELECT t.vid, t.name FROM {term_data} t WHERE t.tid IN ('. db_placeholders($tids) .')', 't', 'tid'), $tids);
	
	$vids = '';
	while ($term = db_fetch_object($resultVid)) {
	    $vids[] = $term->vid;
	}	
	
	$tipoMateriasVid = 3;
	$resultTipo = db_query(db_rewrite_sql('SELECT tid,name FROM term_data WHERE vid = %d'), $tipoMateriasVid);
	
	$arrTids = array();
	$arrTipo = array();
	while ($termTipo = db_fetch_array($resultTipo)) {
	     $arrTids[] = $termTipo['tid'];
	}
	
	$tidsTipo = implode(",", $arrTids);
	
	// get list of terms that have nodes inside it
	$resultVid = db_query(db_rewrite_sql('SELECT DISTINCT td.tid,td.name FROM {node} n, {term_data} td, {term_node} tn WHERE n.nid=tn.nid AND td.tid = tn.tid AND tn.tid IN ('. $tidsTipo .') AND n.nid IN (SELECT n.nid FROM node n, term_data td, term_node tn WHERE n.nid=tn.nid AND tn.tid = %d)'), $tids[0]);
	
	$arrTerms = array();
	while($termVid = db_fetch_array($resultVid)) {
	    $arrTerms[] = $termVid;
	}

	// para deixar o titulo como somente o primeiro
	if ($vids[1] == 4) {
	    $result = db_query(db_rewrite_sql("SELECT name,tid FROM term_data WHERE tid = %d"), $tids[0]);
	    $itemTitle = db_fetch_array($result);
	    $title = $itemTitle['name'];
	    
	    $variables['title'] = $title;
	    $variables['head_title'] = $title;
	}

	$variables['tids'] = $tids;
	$variables['arrTerms'] = $arrTerms;
	$variables['vids'] = $vids;

	/**
	 *
	 *  define navegacao especial para termos de assuntos / tipos de materias
	 *
	 */
	
	$atual = '';
	$separator = '|';
	
	// vale somente nas taxonomias de assuntos
	if (in_array(4, $vids)) {
	    if (count($variables['arrTerms']) > 0)
		$contentTerms = "filtrar por tipo:<br />";
	    
	    for ($i = 0; $i < count($variables['arrTerms']); $i ++) {
		$term = $variables['arrTerms'][$i];
		$urlTerm = url('taxonomy/term/');
		$urlTerm .= ($term['tid']) ? $tids[0] ."," . $term['tid'] : $tids[0];
		$atual = ($tids[1] == $term['tid']) ? 'atual' : '';
		$separator = ($i == count($variables['arrTerms']) - 1) ? '' : $separator;  
		$contentTerms .= "<li class='$atual'><a href='$urlTerm'>" . $term['name'] . "</a> $separator</li>";
	    }
	    $variables['content'] = $contentTerms . $variables['content'];
	}
    }
}


/***********************************
 *    ----------------------------------
 *    | phptemplate_taxonomy_term_page |
 *    ----------------------------------
 *
 *  funciona junto a taxonomy_preprocess
 * 
 *
 ***********************************/
function phptemplate_taxonomy_term_page($tids = '', $result)  {
    return theme_taxonomy_term_page ($tids, $result);
}




/***********************************
 *    -------------------
 *    | NODE PREPROCESS |
 *    -------------------
 * 
 *  todas as requisicoes que passam por node passam aqui
 *  (quase todas ou todas, imagino)
 *
 *  Nessa funcao eh possivel setar novas variaveis que estarao
 *  disponiveis no template. Note que cada template tem um escopo 
 *  a parte e que nem toda variavel estara disponivel em cada um.
 *
 *
 *  ## Conteudo ##
 *
 *  1. filtro para trocar imagens por thumbnail na home, 
 *  caso existam imagens
 *
 *  2. preparando bloco especifico para revistas e jornais
 *
 *  3. rearranjo do visual de book (revista/jornal no primeiro nivel)
 *
 * 
 ***********************************/
function node_preprocess(&$variables, $type) {
    
    // ---------
    // 1. filtro para trocar imagens por thumbnail na home //
    // ---------
    
    if ($variables['is_front'] && $variables['teaser'] == 1 && $variables['type'] != 'book') {
	if (preg_match('/<img/', $variables['content'])) {
	
	    /*
	     * padroes para imagens com img_assist
	     */
	    // substitui por capa
	    $teaser = preg_replace('/<img src=[\"\']{1}(.+)\.([A-Za-z]*)[\"\']{1}/',
				   '<img src=\'$1.thumbnail.$2\'',
				   $variables['content']);
	    
	    // tira os tamanhos para nao esticar a imagem
	    $teaser = preg_replace('/width=[\"\']{1}(.+)[\"\']{1}/',
				   '',
				   $teaser);
	    $teaser = preg_replace('/height=[\"\']{1}(.+)[\"\']{1}/',
				   '',
				   $teaser);
	    
	    // substitui a classe
	    $teaser = preg_replace('/class=\'image ([^"]*)\'/',
				   'class=\'image thumbnail\'',
				   $teaser);
	    
	    // remove a legenda da imagem do teaser
	    $teaser = preg_replace('/<strong>(.+)<\/strong>/', '', $teaser);	    
	    
	    $variables['content'] = $teaser;
	}
    }
    

    // ---------    
    //  2. preparando bloco especifico para revistas e jornais    
    // ---------
    //
    // - define variaveis em escopo global
    // - busca categorias das secoes
    // - mescla e ordena os itens do menu de acordo com a ordem desejada
    
    // puxa variaveis globais para setar
    global $nidAtual, $parentTitle;
    
    // pega o mlid do book pai e descobre o nome e seta $parentTitle
    if ($variables['book_link']['p1']) {
	$resBookPai = db_query(db_rewrite_sql("SELECT n.nid,n.title FROM book b, {node} n WHERE b.nid=n.nid AND b.mlid = %d"), $variables['book_link']['p1']);
	$bookPai = db_fetch_array($resBookPai);
	$parentNid = $bookPai['nid'];
	$parentTitle = $bookPai['title'];
    }

    // seta nid da pagina atual (global)
    if ($variables['book_link']['p2']) {
	$resBookEdicao = db_query(db_rewrite_sql("SELECT n.nid,n.title FROM book b, {node} n WHERE b.nid=n.nid AND b.mlid = %d"), $variables['book_link']['p2']);
	$bookEdicao = db_fetch_array($resBookEdicao);
	$nidAtual = $bookEdicao['nid'];  
    }
    
    // se for block de revista/jornal
    if ($type == 'block'  && in_array($variables['block']->bid, array(24,26))) {
	$types = array("Jornal Sem Terra", "Revista Sem Terra");
       	if (in_array($parentTitle, $types)) {   
	    
	    $resultSecoesBook = db_query(db_rewrite_sql("SELECT b.nid, td.name as secao FROM {menu_links} ml, {book} b, {book} b2, {term_data} td, {term_node} tn WHERE td.tid = tn.tid AND tn.nid = b.nid AND ml.mlid = b.mlid AND ml.p2 = b2.mlid AND b2.nid = %d"), $nidAtual);
	    
	    global $arrSecoesBook;
	    while($secaoBook = db_fetch_array($resultSecoesBook)) {
		$secao = $secaoBook['secao'];
		$arrSecoesBook[$secao] = array('url' => 'node/' . $secaoBook['nid']);
	    }
	    
	    // define secoes fixas e ordena	    
	    // ordem desejada E outros dados
	    
	    
	    //				  'Assinaturas' => array('url' => 'revista/node_' .$nidAtual),
	    //				  'Assinaturas' => array('url' => 'revista/node_' .$nidAtual .'/node/'),
	    if ($parentTitle == 'Revista Sem Terra') {
		$arrOrder = array('Página Inicial'  => array('url' => 'node/' . $nidAtual),
				  'Destaque' => 'destaque', 
				  'Editorial' => 'editorial', 
				  'Reportagens' => 'reportagens', 
				  'Expediente' => 'expediente', 
				  
				  'Assinaturas' => array('url' => 'assinaturas/revista'),
				  'Onde Comprar' => array('url' => 'onde_comprar'), 
				  'Fale Conosco' => array('url' => 'fale_conosco'),
				  
				  'Edições da Revista' => array('url' => 'revistas')
				  );
	    } else if ($parentTitle == 'Jornal Sem Terra') {
		$arrOrder = array('Página Inicial'  => array('url' => 'node/' . $nidAtual),
				  'Editorial' => 'editorial', 
				  'Destaque' => 'destaque', 
				  'Entrevista' => 'entrevista',
				  'Artigo' => 'artigo',
				  'Estados' => 'estados', 
				  'Internacional' => 'internacional', 
				  'Realidade Brasileira' => 'realidade brasileira', 
				  'Expediente' => 'expediente',
				  
				  'Assinaturas' => array('url' => 'assinaturas/jornal'),
				  'Fale Conosco' => array('url' => 'fale_conosco'),
				  
				  'Edições do Jornal' => array('url' => 'jornais')
				  );		
	    }
	    
	    // mesclar secoesBook com outros
	    $arrCompleto = array_merge_recursive($arrOrder, $arrSecoesBook);
	    
	    $arrOrdenado = array();
	    foreach ($arrOrder as $key => $value) {
		$arrOrdenado[$key] = $arrCompleto[$key];
	    }
	    $arrSecoesBook = $arrOrdenado;
	    //	    	    print_r($arrSecoesBook);
	}
    }

    // ---------
    // 3. rearranjo do visual de book (revista/jornal no primeiro nivel)
    // ---------
    //
    // - puxa materia destaque e preenche o miolo
    
    // aqui eu tenho q ver se eh isso mesmo    
    if ($type == 'book_navigation') {
	// visao por node/%	    
	if ($variables['book_link']['p2']) {
	    // pega texto da materia destaque (tid 32 ou 42)
	    if ($variables['parent_title'] == 'Revista Sem Terra')
		$tid = 32;
	    if ($variables['parent_title'] == 'Jornal Sem Terra')
		$tid = 42;
	    if ($variables['parent_title'] == 'Especiais')
		$tid = 32;
	    
	    $sqlEditorial = db_query(db_rewrite_sql("SELECT nr.title,nr.teaser,nr.body FROM {node_revisions} nr, {menu_links} ml, {book} b, {book} b2, {term_data} td, {term_node} tn WHERE td.tid = tn.tid AND tn.nid = b.nid AND ml.mlid = b.mlid AND ml.p2 = b2.mlid AND nr.nid = tn.nid AND td.tid = %d AND b2.nid = %d"), $tid, $nidAtual);
	    
	    $resEditorial = db_fetch_array($sqlEditorial);
	    $texto = $resEditorial['teaser'] ? $resEditorial['teaser'] : $resEditorial['body'];
	    // substitui quebras de linha por <br />
	    
	    $texto = str_replace("\n", "<br />", $texto);
	    // sobrescreve a arvore com o conteudo do editorial
	    $tree = $variables['tree'];
	    $variables['tree'] = "<h2>". $resEditorial['title'] ."</h2><br/>" .  $texto . $tree;
	}
    }

    
    // ---------
    // 4. navegacao das imagens de galerias
    // ---------
    //
    // - 
    if ($variables['type'] == 'image') {
	if (!empty($variables['taxonomy'])) {
	    
	    $tidArr = explode("_", key($variables['taxonomy']));
	    $tid = $tidArr[2];
	    
	    // default: thumbnail - Pode mudar
	    $imageSize = "thumbnail";

	    $resultImage = db_query(db_rewrite_sql("SELECT f.filepath, tn.nid FROM {term_node} tn, {image} i, {files} f WHERE tn.nid = i.nid AND f.fid = i.fid AND i.image_size = '%s' AND tn.tid = '%d'"), $imageSize, $tid);
	    $arrImages = array();
	    while($imageThumb = db_fetch_array($resultImage)) {
		$arrImages[] = $imageThumb;
	    }
	    if (!empty($arrImages)) {
		$variables['arrImages'] = $arrImages;
	    }

	    // monta o html
	    
	    if (!empty($variables['arrImages'])) {
		
		$thumbNavBegin = "<ul class='images' style='width: 500px;'>\n";
		$thumbNavMiddle = "";
		
		for ($x = 0; $x < count($variables['arrImages']); $x++) {
		    $imageItem = $variables['arrImages'][$x];
		    $style = "";
		    // se for o atual, faz prev/next
		    if ($imageItem['nid'] == $variables['nid']) {
			$style = " font-weight: bold";
			
			// soh faz previous a partir do segundo
			if ($x > 0) {
			    $urlPrev = url($variables['arrImages'][$x - 1]['filepath']);
			    $prev = url("node/" . $variables['arrImages'][$x - 1]['nid']);
			}
			
			// soh faz next ate o penultimo
			if (($x + 1) < count($variables['arrImages'])) {
			    $urlNext = url($variables['arrImages'][$x + 1]['filepath']);
			    $next = url("node/" . $variables['arrImages'][$x + 1]['nid']);
			}
			
			if ($prev) {
			    $prevStr = "<a href='$prev'><img border='0' src='$urlPrev'> << Anterior </a>\n";
			} else {
			    $prevStr = "<li style='display: inline; margin-left: 170px'>&nbsp;</li>";
			}
			
			if ($next) {
			    $nextStr .= "<a href='$next'> Próxima >> <img border='0' src='$urlNext'></a>";
			}
		    }
		    $urlNode = url("node/" . $imageItem['nid']);
		    
		    $iX = $x + 1;
		    $thumbNavMiddle .= "<li style='display:inline;$style'><a href='$urlNode'> $iX </a></li>\n";
		    next($variables['arrImages']);
		}
		
		$variables['imageGalleryNavigation'] = $thumbNavBegin . $prevStr . $thumbNavMiddle . $nextStr;
	    }


	}
    }
}

// gambiarra - defini algumas variaveis como globais pra poder alcancar do block
$nidAtual = '';
$parentTitle = '';
$arrSecoesBook = array();