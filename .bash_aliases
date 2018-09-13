#!/bin/bash

## SHELL UTILS
alias rebash='source ~/.bashrc'
alias dot-files='\cp .b* .v* ~/; rebash'
alias timestamp="date +'%s'"

# shell commands
alias ls='ls --color=always -F --group-directories-first'
alias ll='ls -lhA'
alias tree='tree -ahF -C'
alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias cat='pygmentize -O style=monokai -f console256 -g' # Syntax highlighted output when cat ~ require python-pygments

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -pv'

alias grep='grep --color=auto'
alias ping='ping -c 5'

alias free="free -mt"
alias ps="ps auxf"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e" # Make process table searchable

alias whois="whois -h whois-servers.net"
alias wget="wget -c"

# net utils
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'

alias list-sockets='lsof -i' # List Sockets in use
alias list-open-ports='netstat -tulanp'
alias list-tcp-open-ports='netstat -anop | grep -i list | grep tcp'

#utils
alias trim="sed -e 's/^[[:space:]]*//g' -e 's/[[:space:]]*\$//g'" # Trim / remove leading and trailing whitespaces

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
alias strtolower='python -c "import sys; s=sys.argv[1]; print s.lower()"'

# apps
alias intellij="nohup ~/.opt/idea-IC-133.696/bin/idea.sh &"
alias androidstudio="nohup /opt/android-studio/bin/studio.sh &"
alias mendeley="nohup /opt/mendeleydesktop-1.13.3-linux-x86_64/bin/mendeleydesktop &"
alias omnetpp="nohup ~/.opt/omnetpp-4.6/bin/omnetpp &"

# Youtube Downloader
alias yt='youtube-dl -x --audio-format mp3 '
alias sync-music='rsync -avzh --progress /home/nicola/Musica/ /media/nicola/VERBATIM/'
