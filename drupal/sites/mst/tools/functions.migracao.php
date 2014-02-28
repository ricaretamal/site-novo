<?php

  /*
$oldDb = "mst_antigo";
$newDb = "mst_novo";
$dbUser = "root";
$dbPass = "";
*/

$oldDb = 'mst';
$newDb = 'mst2';
$dbUser = 'mst2';
$dbPass = 'd#s3j)sdAt5rR$';

function connect() {
    global $dbUser, $dbPass;
    return $mysqlCon1 = mysql_pconnect('localhost', $dbUser, $dbPass);
}


function nextId($table, $field) {
    
    // Retorna o proximo valor a ser inserido
    global $newDb;

    mysql_select_db($newDb);
    $maxSql = "SELECT MAX($field) as max FROM $table";
    $maxQuery = mysql_query($maxSql);
    $idRes = mysql_fetch_array($maxQuery);
    
    $idRes['max'] = $idRes['max'] + 1;
    
    //  print "<br />Table <b>" . $table . "</b><br />";
    //  print "id <b>" . $idRes['max'] . "</b><br />";
    
    return $idRes['max'];
}



?>