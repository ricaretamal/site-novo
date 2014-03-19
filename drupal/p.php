<?php
$j =  '{"mysql-5.1":[{"name":"mst_ba-mysql-55594","label":"mysql-5.1","plan":"free","tags":["mysql","mysql-5.1","relational","mysql-5.1","mysql"],"credentials":{"name":"d95754c648b394161b75d4513549d8657","hostname":"us01-user01.crtks9njytxu.us-east-1.rds.amazonaws.com","host":"us01-user01.crtks9njytxu.us-east-1.rds.amazonaws.com","port":3306,"user":"ufJnrYuaNgUxo","username":"ufJnrYuaNgUxo","password":"pYlmcAzfejH5t"}}]}';


if(isset($j)){
  $obj = json_decode($j,true);
  $host = ($obj["mysql-5.1"][0]["credentials"]["host"]);
  $port =  ($obj["mysql-5.1"][0]["credentials"]["port"]);
  $user = ($obj["mysql-5.1"][0]["credentials"]["username"]);
  $pass = ($obj["mysql-5.1"][0]["credentials"]["password"]);
}

?>
