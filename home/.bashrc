#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

common () {
    ## env
    TERM="xterm"
    EDITOR="vim"
    PS1="\[\e[1;30;46m\]| $ \h@\W $ [$(date +%D)] (\u) \n\[\e[0m\]\[\e[1;36m\]| > \[\e[0m\]"
    PS2="\[\e[1;36m\]| >> \[\e[0m\]"
    HISTSIZE=1000
    HISTFILE=/dev/null
    LC_ALL=en_US.UTF-8
    LANG=en_US.UTF-8
    export TERM EDITOR
    export LESS_TERMCAP_mb=$'\E[01;31m'
    export LESS_TERMCAP_md=$'\E[01;31m'
    export LESS_TERMCAP_me=$'\E[0m'
    export LESS_TERMCAP_se=$'\E[0m'
    export LESS_TERMCAP_so=$'\E[01;44;33m'
    export LESS_TERMCAP_ue=$'\E[0m'

    ## alias
    alias ..='cd ..'
    alias du='du -sh'
    alias df='df -h'
    alias rm='rm -iv'
    alias cp='cp -iv'
    alias mv='mv -iv'
    alias l='ls'
    alias l.='ls -d .*'
    alias la='ls -a'
    alias ll='ls -l'
    alias ..='cd ..'
    alias grep='grep --colour'
    alias arp='arp -n'
    alias now="date +%H%M%S"
    alias day="date +%Y%m%d%H%M%S"
    alias dig="dig +answer +multiline"

    #function
    nocomment () {
        sed 's/^#.*//g; /\/\*/,/*\//d; /^\/\//d; /^ *#.*/d; /^$/d' $1
    }

    convpic () {
        for i in `ls *.${1}`;do
            convert $i -resize 80% -quality 80 +profile "*" $i
        done
    }

}

linux () {
    #. /usr/share/bash-completion/bash_completion
    if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi

    ## env
    if `uname -v|grep Debian &>/dev/null`;then
        DEBEMAIL="hujunu0@gmail.com"
        DEBFULLNAME="huxos"
        alias apt-add='apt-get --no-install-recommends install'
        alias apt-del='apt-get --purge remove'
    fi
    export DEBEMAIL DEBFULLNAME

    ## alias
    alias ls='ls --color=auto -F'
    alias cman='man -M /usr/share/man/zh_CN'
    alias ps='ps alxf'

    pidinfo() {
        load=$(awk '{print $1"|"$2"|"$3}' /proc/loadavg)
        cpu=$(sar 1 5)
        echo "$cpu" |sed -n "3s/\([AP]\)M */\1M        /p"
        echo "$cpu" |sed -n "s/Average: */$load|/p"

        cpu=$(pidstat -u -l -p ALL 1 1)
        echo "$cpu"|sed -n '3s/.*[0-9] [AP]M/# CPUINFO  /p'
        echo "%usr"
        echo "$cpu"|sed -n '4,$p'|sort -nrk4|head -10
        echo "%sys"
        echo "$cpu"|sed -n '4,$p'|sort -nrk5|head -10
        echo "%cpu"
        echo "$cpu"|sed -n '4,$p'|sort -nrk6|head -10
        echo

        mem=$(pidstat -r -l -p ALL 1 1)
        echo "$mem"|sed -n '3s/.*[0-9] [AP]M/# MEMINFO  /p'
        echo "%majlft"
        echo "$mem"|sed -n '4,$p'|sort -nrk5|head -10
        echo "%mijlft"
        echo "$mem"|sed -n '4,$p'|sort -nrk4|head -10
        echo "%mem"
        echo "$mem"|sed -n '4,$p'|sort -nrk8|head -10
    }

}

common
linux
