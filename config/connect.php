<?php 
$host = 'localhost';
$user = 'feature45';
$database_name = 'test';
$host_password = '';

$connect = mysqli_connect($host, $user, $host_password, $database_name);
mysqli_set_charset($connect, 'utf8');