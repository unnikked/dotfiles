#!/bin/bash


function my_ps() { 
	ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; 
}

function pp() { 
	my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; 
}

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

function notify() {
	if [ $# -ne 2 ]; then
		echo "USAGE: $0 \"command\" \"message\""
	fi

	$1
	notify-send "$2"
}

#extract all archives!
function extract () {
   if [ -f $1 ] ; then
       case $1 in
            *.tar.bz2)  tar xvjf $1 ;;
            *.tar.gz)   tar xvzf $1 ;;
            *.tar.xz)   tar Jxvf $1 ;;
            *.bz2)      bunzip2 $1 ;;
            *.rar)      unrar x $1 ;;
            *.gz)       gunzip $1 ;;
            *.tar)      tar xvf $1 ;;
            *.tbz2)     tar xvjf $1 ;;
            *.tgz)      tar xvzf $1 ;;
            *.zip)      unzip $1 ;;
            *.Z)        uncompress ;;
            *.7z)       7z x $1 ;;
            *)          echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

# Creates an archive (*.tar.gz) from given directory.
function maketar() { 
	tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; 
}

# Create a ZIP archive of a file or folder.
function makezip() { 
	zip -r "${1%%/}.zip" "$1" ; 
}

#cli calculator
function calc () {
    awk "BEGIN { print $* ; }"
}

#SSH Tunnel
function ssh-tunnel() {
	if [ -z "$1" -o "$1" = "-h" ]; then
		echo "$(basename $0): [ [SOURCE_HOST [SOURCE_PORT [TARGET_HOST [TARGET_PORT [USERNAME] ] ] ] ] ]"
  		return 1
	fi
	SOURCE_HOST=${1:-0.0.0.0}
	SOURCE_PORT=${2:-7722}
	TARGET_HOST=${3:-localhost}
	TARGET_PORT=${4:-22}

	USERNAME=${5:-bewifi@localhost}
	#DEBUG=""
	DEBUG=echo

	$DEBUG ssh -f "$USERNAME" -L $SOURCE_HOST:$SOURCE_PORT:$TARGET_HOST:$TARGET_PORT -N
}

# Execute command on several servers using ssh
function execute-over-ssh() {
    if [ $# -ne 2 ]; then
        echo "USAGE: execute-over-ssh 'server1 server2 server3' 'command1; command2; command3'"
        return 1
    else
        servers=(${=1})
        for server in $servers; do
            echo ""
            echo "----> Executing $2 on $server"
            ssh $server "$2" 
            echo ""
        done
        return 0
    fi
}


function define() {
    curl -s http://definefor.me/getDefinition.php?word=$(tr ' ' '+' <<< "$@") | \
    grep -A2 definition | grep -v definition | \
    grep -e '[a-zA-Z]' | sed -e 's/^[ \t]*//' | \
    grep -ve '</div>' 
}

function java-compile() {
    if [ ! -d ./bin ]; then 
	mkdir ./bin
	javac -d ./bin $@
    else 
	rm -Rf ./bin/*
	javac -d ./bin $@
    fi
}
    

function sprunge() {
	cat $1 | curl -F 'sprunge=<-' http://sprunge.us
}

function ask() {
    echo -n "$@" '[y/n] ' ; read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}
