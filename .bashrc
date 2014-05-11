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

CLOUDFLARE_EMAIL="your@email.com"
CLOUDFLARE_KEY="yourapikey"