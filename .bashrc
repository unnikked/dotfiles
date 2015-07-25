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
HISTIGNORE="jrnl *"

# add this configuration to ~/.bashrc
export HH_CONFIG=hicolor         # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"   # mem/file sync
# if this is interactive shell, then bind hh to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hh \C-j"'; fi

[[ -f "/home/nicola/.config/autopackage/paths-bash" ]] && . "/home/nicola/.config/autopackage/paths-bash"
