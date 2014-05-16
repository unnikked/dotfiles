#!/bin/bash

## SHELL UTILS
alias rebash='source ~/.bashrc'
alias timestamp="date +'%s'"

# shell commands
alias ls='ls --color=always -F --group-directories-first'
alias lo="ls -lha --color=always -F --group-directories-first | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\"%0o \",k);print}'"
alias ll='ls -lhA'
alias tree='tree -ahF -C'
alias find-here="find . -name "
alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias cat='pygmentize -O style=monokai -f console256 -g' # Syntax highlighted output when cat ~ require python-pygments
alias cat-html="sed 's/<[^>]*>//g'"

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias back='cd $OLDPWD'
alias cd..='cd ..'
alias df="pydf" # sudo apt-get install pydf
alias du='du -h -c'
alias mkdir='mkdir -pv'
alias ..='cd ..'

alias grep='grep --color=auto'
alias ping='ping -c 5'

alias free="free -mt"
alias ps="ps auxf"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e" # Make process table searchable

alias whois="whois -h whois-servers.net"
alias wget="wget -c"

# JAVA
#alias javac="if [ ! -d ./bin ] then; mkdir bin; javac -d ./bin"

# net utils
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias list-sockets='lsof -i' # List Sockets in use
alias list-open-ports='netstat -tulanp' 
alias list-tcp-open-ports='netstat -anop | grep -i list | grep tcp'
alias get-ip="resolveip -s "$1""

# Sysadmin utils
alias apache2-logs="tail /var/log/apache2/error.log | less"

#utils

alias trim="sed -e 's/^[[:space:]]*//g' -e 's/[[:space:]]*\$//g'" # Trim / remove leading and trailing whitespaces

alias randap="< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo;"
alias ?='cowsay -f $(ls /usr/share/cowsay/cows | shuf -n 1 | cut -d. -f1) $(whatis $(ls /bin) 2>/dev/null | shuf -n 1)'

# HTTP serve the current directory to 0.0.0.0 and safety port 8765
# Detect python version
ret=$(python -c 'import sys; print("%i" % (sys.hexversion<0x03000000))')
if [ $ret -eq 0 ]; then    # Python version is >= 3
    alias pyhttp='python -m http.server 8765'
else    # Python version is < 3
    alias pyhttp='python -m SimpleHTTPServer 8765'
fi

#show my current public ip
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

# Show active network listeners
alias netlisteners='lsof -i -P | grep LISTEN'

# Misc
#alias commands-freq='history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10'
alias random-fact="elinks -dump randomfunfacts.com | sed -n '/^| /p' | tr -d \|" 
alias rainbow='yes "$(seq 16 231)" | while read i; do printf "\x1b[48;5;${i}m\n"; sleep .02; done'

alias strtolower='python -c "import sys; s=sys.argv[1]; print s.lower()"'

# Dev Directories
alias dev-python="cd ~/Dropbox/Programming/Python"
alias dev-php="cd ~/Dropbox/Programming/PHP"
alias dev-bash="cd ~/Dropbox/Programming/BASH"
alias dev-java="cd ~/Dropbox/Programming/Java"
alias dev-c="cd ~/Dropbox/Programming/C"
alias dev-c++="cd ~/Dropbox/Programming/C++"
alias dev-ruby="cd ~/Dropvox/Programming/Ruby"

# apps
alias intellij="nohup ~/.opt/idea-IC-133.696/bin/idea.sh &"
