# install PHP

mkdir -p ~/bin
cd ~/bin
wget -nc windows.php.net/downloads/releases/php-5.4.12-nts-Win32-VC9-x86.zip
unzip php-5.4.12-nts-Win32-VC9-x86.zip
chmod +x php.exe php5.dll libeay32.dll ssleay32.dll ext/php_curl.dll
echo extension=ext/php_curl.dll > php.ini