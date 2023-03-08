#!/usr/bin/env bash
#set -ex

if [[ -z $1 ]]; then
        echo 'Provide an arg'
        exit 0
fi

file=/var/log/apt/history.log
#linenum=$(($(grep -n "apt install $1" $file | cut -d':' -f1) - 1))
date=$(grep -i -B 1 "apt install $1" $file | head -n 1 | awk -F ' ' '{print $2" "$3}')

#if (( $linenum < 0 )); then
#        echo 'Package not found'
#        exit 0
#fi

if [ -z "$date" ]; then
  echo 'Package not found'
  exit 0
fi

#echo "$1 was installed on" $(sed -n "$linenum p" $file | awk -F' ' '{print $2" "$3}')

# La fecha y la hora estan separados por dos espacios, es necesario traducir los espacios a uno solo para que
# cut pueda reconocer las columnas. Sin no se hace esto, entro los dos espacios se cuenta una columna con 
# un caracter vacio.
#echo "$1 was installed on" $(sed -n "$linenum p" $file | tr -s ' ' | cut -d ' ' -f 2,3)
echo "$1 was installed on $date" 
