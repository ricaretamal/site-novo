<?php

// $Id$


/**
 *
 * Importacao do vozes da terra
 *
 *  ===SOH serve para o mst===
 *
 * (coloquei aqui porque posso acessar a api de audio para insercao)
 *
 * roteiro:
 * - importar paginas como story, normal (migracao de paginas).
 * - selecionar do bd antigo:
 *   - todas as edicoes com audios - OK
 *   - arquivos relacionados - OK
 * - com a lista, cruzar com bd legacy - OK
 * - dar update por tipo (para 'audio') - OK
 * - inserir todos os arquivos
 *
 *
**/

/**
 *
 * Casos a parte (inserir na mao):
 * id 4196 (3 mp3)
 * id 4024 (5 mp3)
 * audios - tem mp3 no corpo, mp3 estao na pasta. Links duros no corpo
 * 4128, 4194, 4195, 4196
 * 4000 - varios audios!
 * (4000, 4024, 4128, 4194, 4195, 4196)
 **/

// HARD CODED - mudar em cada sistema (Nao vou fazer admin pra isso!)
global $filepathMp3;
$filepathMp3 = "/data/web/mst-novo/public_html/drupal/sites/mst/files/migracao/mp3/";  

function set_filepath($filepath) {
    global $filepathMp3;
    $filepath = $filepathMp3 . $filepath . ".mp3";
    return $filepath;
}


function migracao_vozes_import_form() {
    global $filepathMp3;
    
    $form = array();
    // importa do banco antigo
    mysql_select_db('mst');
    $res_sql = db_query("SELECT id FROM tbl_paginas WHERE mp3 != '' AND id NOT IN (4000, 4024, 4128, 4194, 4195, 4196)");
    $node_list = array();
    
    mysql_select_db('mst2');
    while ($pagina = db_fetch_object($res_sql)) {
	$nid = db_result(db_query("SELECT nid FROM legacy WHERE old_id = %d", $pagina->id));
	$node = node_load($nid);
	$filepath = $filepathMp3 . $pagina->id . "_1.mp3";
	if (file_exists($filepath)) {
	    _migracao_vozes_insert_audio($node, $filepath);
	}
    }

    // anexados
    mysql_select_db('mst');
    $res_sql = db_query("select id,texto from tbl_paginas where texto like '%mp3%' AND secoes_id != 30");
    $files = array();
    while($item = db_fetch_object($res_sql)) {
	mysql_select_db('mst2');
	$nid = db_result(db_query("SELECT nid FROM legacy WHERE old_id = %d", $item->id));
	$node = node_load($nid);	
	preg_match_all('/mp3\/(.+)\.mp3/', $item->texto, $files);
	$node->body = preg_replace('/http\:\/\/(.+)\/mp3\/(.+)\.mp3/i', 'http://www.mst.org.br/sites/mst/files/$2.mp3', $item->texto);
	// substitute the filename
	$files[1] = array_map('set_filepath', $files[1]);
	
	_migracao_vozes_attach_audios($node, $files[1]);
    }
    

    // 
    mysql_select_db('mst2');
    
    return $form;
}


/**
 * anexa lista de arquivos pra um dado node
 *
 * $node @object
 * $files @array
 **/
function _migracao_vozes_attach_audios($node, $files) {
       
    mysql_select_db('mst_novo');
    foreach ($files as $filepath) {
	
	$file = new stdClass();
	$file->uid = $user->uid;
	$file->filepath = $filepath;
	$file->filename = basename($file->filepath);
	$file->filemime = module_exists('mimedetect') ? mimedetect_mime($file->filepath) : file_get_mimetype($file->filepath);
	$file->filesize = filesize($file->filepath);
	$file->timestamp = time();
	$file->status = FILE_STATUS_TEMPORARY;
	drupal_write_record('files', $file);
	
	$upload = new stdClass();
	$upload->fid = $file->fid;
	$upload->nid = $node->nid;
	$upload->vid = $node->vid;
	$upload->description = basename($file->filepath);
	$upload->list = 0;
	$upload->weight = 0;
	drupal_write_record('upload', $upload);
	
	$node->promote = 0;
	$node = node_submit($node);
	node_save($node);
    }
}


/**
 *
 * - pega os nodes 'audio'
 * - recebe e insere um arquivo
 * - aplica funcoes de audio
 *
 *
 * baseado em: function audio_api_insert (v 6.x audio.module,v 1.151)
 */
function _migracao_vozes_insert_audio($node, $filepath) {
    global $user;
    
    // For node_object_prepare()
    module_load_include('inc', 'node', 'node.pages');
    
    // Begin building file object.
    $file = new stdClass();
    $file->uid = $user->uid;
    $file->filepath = $filepath;
    $file->filename = basename($file->filepath);
    $file->filemime = module_exists('mimedetect') ? mimedetect_mime($file->filepath) : file_get_mimetype($file->filepath);
    $file->filesize = filesize($file->filepath);
    $file->timestamp = time();
    $file->status = FILE_STATUS_TEMPORARY;
    drupal_write_record('files', $file);
    
    // usa registro existente   
    $node->type = 'audio';
    $node->promote = 0;
    
    
    $node->audio = array(
    'downloadable' => variable_get('audio_default_downloadable', 1),
    'play_count' => 0,
    'download_count' => 0,
    'file' => $file,
    );
    
    node_object_prepare($node);
    
    // Allow other modules to modify the node (hopefully reading in tags).
    audio_invoke_audioapi('upload', $node);
    
    // Add the tags (overwriting any that audio_getid3 may have loaded).
    if ($tags) {
	$node->audio_tags = $tags;
    }
    
    // Build the title manually (since we don't call node_validate()).
    if (empty($node->title_format)) {
	$node->title_format = variable_get('audio_default_title_format', '[audio-tag-title-raw] by [audio-tag-artist-raw]');
    }
    
    /*
    // Flush the token cache, otherwise when importing multiple nodes they'll all
    // have the same title.
    token_get_values('node', $node, TRUE);
    $node->title = token_replace($node->title_format, 'node', $node);
    drupal_write_record('files', $file);
    */
    // Save it.
    $node = node_submit($node);
    node_save($node);    

    
    
    ////////////
    // puxei todo esse codigo do audio.module pois estou alterando um node (uma acao incomum e inesperada)
    $node->audio['file']->timestamp = time();
    $node->audio['file']->filesize = filesize($node->audio['file']->filepath);
    $node->audio['file']->status |= FILE_STATUS_PERMANENT;
  // If there's an fid update, otherwise insert.
    $file_update = empty($node->audio['file']->fid) ? array() : array('fid');
    drupal_write_record('files', $node->audio['file'], empty($node->audio['file']->fid) ? array() : array('fid'));
    
    // Save the audio row.
    $audio = array_merge($node->audio, array('nid' => $node->nid, 'vid' => $node->vid, 'title_format' => $node->title_format, 'fid' => $node->audio['file']->fid));
    $audio_update = ($node->is_new || $node->revision) ? array() : array('vid');
    drupal_write_record('audio', $audio);

    
    // Remove any existing metadata.
    db_query("DELETE FROM {audio_metadata} WHERE vid=%d", $node->vid);
    /*
     * Removido - gerava tags nada a ver
    // Save the new tags.
    $allowed_tags = audio_get_tags_allowed();
    foreach ($node->audio_tags as $tag => $value) {
	if (in_array($tag, $allowed_tags) && $value) {
	    $metadata = array('vid' => $node->vid, 'tag' => $tag, 'value' => $value, 'clean' => audio_clean_tag($value));
	    drupal_write_record('audio_metadata', $metadata);
	}
    }
    */
    
}
