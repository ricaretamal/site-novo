<?php
// $Id: template.php,v 1.2.2.5 2008/10/20 12:39:39 liorkesos Exp $
/**
* Force refresh of theme registry.
* DEVELOPMENT USE ONLY - COMMENT OUT FOR PRODUCTION
*/
// drupal_rebuild_theme_registry();

/**
  * Tendu Drupal - A CSS Theme For Developers
  * Author: Tom Bigelajzen - http://tombigel.com
  * Initial Drupal 6 porting: Lior Kesos - http://www.linnovate.net
  * Further improvements to code by Zohar Stolar (http://drupal.org/user/48488) of Linnovate and Tom Bigelajzen 
  *
  * This theme is Cross-browser and RTL ready.
  * It is extremely minimal and ment to be a wireframe for
  * theme developers to build bi-directional themes. 
  */


/**
 * Override or insert PHPTemplate variables into the page templates.
 *
 * @param $vars
 *   A sequential array of variables to pass to the theme template.
 */

function phptemplate_preprocess_page(&$vars) {  // Build array of helpful body classes
  $body_classes = array();
  // Page user is logged in
  $body_classes[] = ($vars['logged_in']) ? 'logged-in' : 'not-logged-in';
  // Page is front page
  $body_classes[] = ($vars['is_front']) ? 'front' : 'not-front'; 
  
  //Clean these strings from special characters (TODO: do we need this check?)
  $_page_type = str_replace(array('][', '_', ' '), '-', arg(0));
  $_node_type = str_replace(array('][', '_', ' '), '-', $vars['node']->type);
  // Page type (for admin, node, etc.)
  $body_classes[] = preg_replace('![^abcdefghijklmnopqrstuvwxyz0-9-_]+!s', '', 'page-' . $_page_type);
  //If node page, print node type
  if (isset($vars['node']) && $vars['node']->type) {
    $body_classes[] = 'node-type-'. $_node_type;
  }
  
  //Add classes depended on sidebars
  if ($vars['left'] && $vars['right']) {
    $body_classes[] = 'two-sidebars';
  } elseif (!$vars['left'] && !$vars['right']){
    $body_classes[] = 'no-sidebars';
  } else{
    $body_classes[] = 'one-sidebar';
  }

  if ($vars['left']) {
    $body_classes[] = 'with-sidebar-left';
  }
  if ($vars['right']) {
    $body_classes[] = 'with-sidebar-right';
  }
  $body_classes = array_filter($body_classes); // Remove empty elements
  $vars['body_classes'] = implode(' ', $body_classes);// Create class list separated by spaces
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
 *  1. pega materia destaque para capa de revista/jornal
 *
 * 
 ***********************************/
function node_preprocess(&$vars, $type) {
    
    // ---------
    // 1. pega materia destaque para capa de revista/jornal
    // ---------
    //
    if ($type == 'book_navigation') {
	// visao por node/%	    
	if ($vars['book_link']['p2'] != 0 && $vars['book_link']['p3'] == 0 && $vars['book_link']['p1'] != 170) {
	    $tid = 32; 
	    $nid = arg(1);
	    $resEditorial = db_query(db_rewrite_sql("SELECT nr.nid FROM {node_revisions} nr, {menu_links} ml, {book} b, {book} b2, {term_data} td, {term_node} tn WHERE td.tid = tn.tid AND tn.nid = b.nid AND ml.mlid = b.mlid AND ml.p2 = b2.mlid AND nr.nid = tn.nid AND td.tid = %d AND b2.nid = %d"), $tid, $nid);

	    $editorial_nid = db_result($resEditorial);
	    $node_load = node_load($editorial_nid);
	    $texto = node_view($node_load, TRUE, 0, 0);
	    
            if ($node_load->teaser != '') {
	      $texto .= "<h3><a href='" . url($node_load->path) . "'>" . t('Read more') . "</a></h3><br/>";    
            }
	    // sobrescreve a arvore com o conteudo do editorial
	    $vars['tree'] = $texto . $vars['tree'];
	}
    }
}

?>
