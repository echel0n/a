#!/bin/bash
# Requires: php-bcmath, php-curl, php-simplexml

binparse ()
{
  grep -Eaozm1 "$1" a.core
}

pgrep ()
{
  ps -W | awk /$1/'{print$4;exit}'
}

warn ()
{
  printf "\e[1;35m%s\e[m\n" "$*"
}

pkill ()
{
  pgrep $1 | xargs kill -f
}

quote ()
{
  [[ ${!1} =~ [\ \&] ]] && read $1 <<< \"${!1}\"
}

log ()
{
  local pp
  for oo
  do
    quote oo
    pp+=("$oo")
  done
  warn "${pp[@]}"
  eval "${pp[@]}"
}

ab=/opt/Scripts/AdobeHDS.php
pc=plugin-container
pkill $pc
echo ProtectedMode=0 2>/dev/null >$WINDIR/system32/macromed/flash/mms.cfg
warn 'Killed flash player for clean dump.
Restart video then press enter here.'
read

until read < <(pgrep $pc)
do
  warn "$pc not found!"
  read
done

rm -f a.core
dumper a $REPLY &

until [ -s a.core ]
do
  sleep 1
done

kill %%
read ah < <(binparse "pvtoken.*")
read mn < <(tr "[:cntrl:]'<>" "\n" < a.core | grep '^http://[^?]*\.f4m')
read ur < <(binparse "Mozilla/5.0.*")
echo extension=ext/php_curl.dll > /usr/local/bin/php/php.ini
rm a.core

log php "$ab" --manifest "$mn" ||
log php "$ab" --manifest "$mn" --auth "$ah" --useragent "$ur"
