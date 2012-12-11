<?php

function pkcs5_pad($input, $blockSize) 
{
	$padLength = $blockSize - (strlen($input) % $blockSize);
	return $input . str_repeat(chr($padLength), $padLength);;
}
function pkcs5_unpad ($text)
{
	$pad = ord($text{strlen($text)-1});
	if ($pad > strlen($text)) return false;
	if (strspn($text, chr($pad), strlen($text) - $pad) != $pad) return false;
	return substr($text, 0, -1 * $pad);
}
$input = 'abcdefghijklmnopqrstuwvxyz';
$iv = '00000000';
$key = '1234567890123456';


// $c = mcrypt_module_open('blowfish', '', 'cfb', '');
// mcrypt_generic_init($c, $key, $iv);
// $enc = mcrypt_generic($c, $input);
// echo (unpack('h*', $enc)[1]) . PHP_EOL;

echo ' PHP :: Actual' . PHP_EOL;
echo '      IN: ' . strlen($input) . ' :: ' . $input . PHP_EOL;

// $input = pkcs5_pad($input, mcrypt_module_get_algo_block_size('blowfish'));
$enc = mcrypt_encrypt('blowfish', $key, pkcs5_pad($input, 8), 'ecb', $iv);
echo ' ECB OUT: ' . strlen($enc) . ' :: ' . (unpack('h*', $enc)[1]) . PHP_EOL;
$enc = mcrypt_encrypt('blowfish', $key, pkcs5_pad($input, 8), 'cbc', $iv);
echo ' CBC OUT: ' . strlen($enc) . ' :: ' . (unpack('h*', $enc)[1]) . PHP_EOL;
$enc = mcrypt_encrypt('blowfish', $key, $input, 'cfb', $iv);
echo ' CFB OUT: ' . strlen($enc) . ' :: ' . (unpack('h*', $enc)[1]) . PHP_EOL;
$enc = mcrypt_encrypt('blowfish', $key, $input, 'ncfb', $iv);
echo 'NCFB OUT: ' . strlen($enc) . ' :: ' . (unpack('h*', $enc)[1]) . PHP_EOL;
$enc = mcrypt_encrypt('blowfish', $key, $input, 'ofb', $iv);
echo ' OFB OUT: ' . strlen($enc) . ' :: ' . (unpack('h*', $enc)[1]) . PHP_EOL;
$enc = mcrypt_encrypt('blowfish', $key, $input, 'nofb', $iv);
echo 'NOFB OUT: ' . strlen($enc) . ' :: ' . (unpack('h*', $enc)[1]) . PHP_EOL;