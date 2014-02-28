<?php
$cssExtra = '';
if (in_array($block->bid, array(24, 26))) {

    global $arrSecoesBook;
    
    $cssExtra = " menu-revjorn";
    $menuSecoes = "<ul class='menu-revjorn'>";
    //    if ($arrSecoesBook) {
	foreach ($arrSecoesBook as $chave => $secao) {
	    $url = $secao['url'];	
	$menuSecoes .= "<li><a href='". url($url) ." '>". $chave ."</a><br/></li>";
	}
	$menuSecoes .= "</ul>";
	//    }
    $block->content .= $menuSecoes;
}

// $Id: block.tpl.php,v 1.3 2007/08/07 08:39:36 goba Exp $
?>
  <div class="block block-<?php print $block->module; print $cssExtra;?>" id="block-<?php print $block->module; ?>-<?php print $block->delta; ?>">
<?php if ($block->subject) { ?>
    <h2 class="title"><?php print $block->subject; ?></h2>
<? } ?>
    <div class="content"><?php print $block->content; ?></div>
 </div>
