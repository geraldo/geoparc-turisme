<?php

// request to external server to insert target="_blank" into URL

header('Content-Type: text/html');
header('Access-Control-Allow-Origin: *');

if (isset($_GET['url']) && $_GET['url'] !== '') {

	$content = file_get_contents( $_GET['url'] );

	$pos = stripos($content, '<a href="https://www1.sedecatastro.gob.es');

	$part1 = substr($content, 0, $pos);
	$part2 = '<a target="_blank" ';
	$part3 = substr($content, $pos + 3);

	echo $part1 . $part2 . $part3;
}
?>