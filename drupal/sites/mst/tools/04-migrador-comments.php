<?php
/****

 Script para migrar comments

*/

require("functions.migracao.php");
require("apiMigratoria.php");
$mysqlCon = connect();

mysql_select_db($oldDb);

// migrando somente os comentarios autorizados (jogando fora o resto)
$sql = "SELECT nome AS name,email AS mail, mensagem AS comment, UNIX_TIMESTAMP(postagem) AS timestamp FROM tbl_mural WHERE autorizado = 1";
$resultComments = mysql_query($sql);

while ($comment = mysql_fetch_assoc($resultComments)) {
    $comment['nid'] = 12;
    $comment['uid'] = 1;
    
    mysql_select_db($newDb);
    insertComment($comment);
}

?>