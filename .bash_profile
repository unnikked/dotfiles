#!/bin/bash

CLASSPATH=.:./bin
export CLASSPATH

COMPOSER=/home/nicola/.composer/vendor/bin/

PATH=$PATH:$HOME:$COMPOSER
export PATH

# Prompt
# for code in {0..255}; do echo -e "\e[38;05;${code}m $code: Test"; done
c_lg="\[\033[38;5;141m\]" # lines command ok
c_lf="\[\033[38;5;196m\]" # lines command fail
c_us="\[\033[38;5;106m\]" # user
c_at="\[\033[38;5;111m\]" # at symbol @
c_ho="\[\033[38;5;167m\]" # host
c_wd="\[\033[38;5;220m\]" # working directory
c_ru="\[\033[38;5;118m\]" # regular user
c_su="\[\033[38;5;196m\]" # root user
c_xx="\[\e[0m\]" # reset
# truncated working directory
twd() {
    local result=$PWD
    local dynamic
    dynamic="`whoami`$HOSTNAME" # for calculating max pwd length
    local len_extra_chars=5 # length of misc characters and spaces on first line
    local len_term=${COLUMNS:-80} # if no variable $COLUMNS use 80
    local len_max_pwd=$((len_term-$len_extra_chars-${#dynamic}))
    local difference=$((len_max_pwd - ${#result}))
    # no need to continue if truncation unnecessary
    if [ "$difference" -gt "0" ]
    then
        echo "$result"
        return
    fi
    local old_ifs=$IFS
    local IFS="/"
    local longest=''
    # find longest dir in working directory (within first line)
    for x in ${result:0:$len_max_pwd}
    do
        if [ "${#x}" -gt "${#longest}" ]
        then
            longest=$x
        fi
    done
    local IFS=$old_ifs
    # find position of longest dir
    local str_pos=0
    while [ "$str_pos" -lt "${#result}" ]
    do
        if [ "${result:$str_pos:${#longest}}" == "$longest" ]
        then
            local trunc_end=$((str_pos+6+($difference*-1)))
            result=${result:0:$((str_pos+3))}...${result:$trunc_end}
            break
        fi
        ((str_pos++))
    done
    echo "$result"
}
get_ps1() {
    [ $? -eq 0 ] && c_ln="${c_lg}" || c_ln="${c_lf}"
    (( EUID == 0 )) && chr_usr="${c_su}#" || chr_usr="${c_ru}$"
    PS1="${c_ln}┌[${c_us}\u${c_at}@${c_ho}\h ${c_wd}$(twd)${c_ln}]\n${c_ln}└${chr_usr}${c_xx} "
}
PROMPT_COMMAND=get_ps1

# Get colors in manual pages
man() {
    env \
    LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
    LESS_TERMCAP_md="$(printf "\e[1;31m")" \
    LESS_TERMCAP_me="$(printf "\e[0m")" \
    LESS_TERMCAP_se="$(printf "\e[0m")" \
    LESS_TERMCAP_so="$(printf "\e[1;44;33m")" \
    LESS_TERMCAP_ue="$(printf "\e[0m")" \
    LESS_TERMCAP_us="$(printf "\e[1;32m")" \
    man "$@"
}

# Whatis ?
echo "Did you know that:"; whatis "$(\ls /bin | shuf -n 1)"

[[ -f "/home/nicola/.config/autopackage/paths-bash" ]] && . "/home/nicola/.config/autopackage/paths-bash"
