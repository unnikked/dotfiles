# If not running interactively, don't do anything
[ -z "$PS1" ] && return

source ~/.bash_profile
source ~/.bash_aliases
source ~/.bash_functions

if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion # enable smart bash completition
fi

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# Get colors in manual pages
man() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

# Whatis ?
echo "Did you know that:"; whatis $(ls /bin | shuf -n 1)
