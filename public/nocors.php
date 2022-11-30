<?php

// request to external server
// workaround to avoid CORS
// response as XML

header('Content-Type: text/xml');
header('Access-Control-Allow-Origin: *');

if (isset($_GET['url']) && $_GET['url'] !== '') {

	$url = $_GET['url'];

	/*$response = file_get_contents($url);

	header('Content-Type: text/plain');
	header('Access-Control-Allow-Origin: *');

	echo $response;*/

	$curl = curl_init();
	curl_setopt ($curl, CURLOPT_URL, $url);
	curl_setopt ($curl, CURLOPT_FOLLOWLOCATION, 1);
	curl_setopt ($curl, CURLOPT_MAXREDIRS, 20);
	curl_setopt ($curl, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt ($curl, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5");
	curl_setopt ($curl, CURLOPT_CONNECTTIMEOUT, 30);
	$text = curl_exec($curl);
	echo $text;
}
?>