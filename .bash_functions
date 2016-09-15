#!/bin/bash

function killps() {   # kill by process name
    local pid pname sig="-TERM"   # default signal
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: killps [-SIGNAL] pattern"
        return;
    fi
    if [ $# = 2 ]; then sig=$1 ; fi
    for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} )
    do
        pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
        if ask "Kill process $pid <$pname> with signal $sig?"
            then kill $sig $pid
        fi
    done
}

function define() {
    curl -s "http://definefor.me/getDefinition.php?word=$(tr ' ' '+' <<< "$@")" | \
    grep -A2 definition | grep -v definition | \
    grep -e '[a-zA-Z]' | sed -e 's/^[ \t]*//' | \
    grep -ve '</div>'
}

function java-compile() {
    if [ ! -d ./bin ]; then
    	mkdir ./bin
    	javac -d ./bin "$@"
    else
    	rm -Rf ./bin/*
    	javac -d ./bin "$@"
    fi
}

function lo() {
  ls -lha --color=always -F --group-directories-first | \
  awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\"%0o \",k);print}'
}

function randap() {
  < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;
}
