#!/bin/sh

curl  -L -o /adminer/www/index.php https://github.com/vrana/adminer/releases/download/v5.2.1/adminer-5.2.1-en.php


#This command starts a built-in web server that comes with PHP (flag -S  , -t the dir root of webserv).
#is used mainly for development and testing PHP websites without needing a full web server like Nginx or Apache.
exec php -S 0.0.0.0:4040 -t /adminer/www