# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
#DISPLAY=':0'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

WHITE="\[\033[1;37m\]"
GREEN="\[\033[0;32m\]"
CYAN="\[\033[0;36m\]"
GRAY="\[\033[0;37m\]"
BLUE="\[\033[0;34m\]"
#export PS1="${GREEN}\u${CYAN}@${BLUE}\h ${CYAN}\w${GRAY} $ "

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}${GREEN}\u${CYAN}@${BLUE}\h:${CYAN}\w${GRAY} $ "
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# ------------------------------------------------------------------
# My Stuff
export EDITOR='vim'
source ~/bin/tmuxinator.bash

#color manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# enable **
shopt -s globstar

#build
#success_message="Build finished sucessfully"
#success_icon="/usr/share/icons/Humanity/actions/48/gtk-ok.svg"
#fail_message="Build Failed"
#fail_icon="/usr/share/icons/Humanity/actions/48/gtk-cancel.svg"
#alias send_build_message_success='notify-send "${success_message}" -i "${success_icon}"'
#alias send_build_message_fail='notify-send "${fail_message}" -i "${fail_icon}"'

alias ff='find -type f'
alias fixedin='echo $(date -u -d"$(git log -1 --pretty=%ci)" +%Y%m%d.%H%M).$(git log -1 --pretty=%h)'
#alias cb='sudo component-build -f ~/build/repo -o ~/build -t kgregory --on-pass=send_build_message_success --on-fail=send_build_message_fail'
#alias rb='sudo recipe-build -f ~/build/repo -o ~/build -t kgregory --on-pass=send_build_message_success --on-fail=send_build_message_fail'

#cdpath and find/grep
export CDPATH=.:~:

export PATH=$PATH:~/bin:
alias fn='find . -iname '
alias grl='grep -Ri '

function gr {
  grep -Ri "$1" *;
}

function sgrep {
  grep -RIisn --exclude=tags --exclude="*~" --exclude-dir="mydiff" --exclude-dir=".deps" --exclude-dir="concordance-lite/src/spec/data/bycast/software/release" --exclude=cscope.out "$1" *;
}

function cpiso {
  if [ -z "$1" ]; then
    version="10.0.0"
  else
    version="$1"
  fi

  rm /mainfile/home/kgregory/iso/*StorageGRID_"$version"*
  cp -v "$version"/NetApp_StorageGRID*iso /mainfile/home/kgregory/iso
}

function build {
  for mod in $@ ; do
    cb -b ~/git/storagegrid/${mod} --force-rebuild
    rc=$?
    if [ $rc -eq 1 ] || [ $rc -eq 3 ] ;  then
      return
    fi
  done
  rb -b ~/git/storagegrid --build-uncommitted-changes
}

function buildn {
  for mod in $@ ; do
    cb -b ~/git/northstar2/storagegrid/${mod} --force-rebuild
    rc=$?
    if [ $rc -eq 1 ] || [ $rc -eq 3 ] ;  then
      return
    fi
  done
  rb -b ~/git/northstar2/storagegrid --build-uncommitted-changes
}


function cb {
#  sudo -H component-build -f ~/build/repo -o ~/build --build-uncommitted-changes -t kgregory "$@"
  sudo -H component-build -f ~/build/repo -o ~/build --build-uncommitted-changes --shared-output-dir=/mainfile/home/rel/build/storagegrid -t kgregory "$@"
  rc=$?
  send_build_message $rc "$2"
  return $rc
}

function rb {
#  sudo recipe-build -f ~/build/repo -o ~/build -t kgregory "$@"
  sudo recipe-build -f ~/build/repo -o ~/build --build-uncommitted-changes --shared-output-dir=/mainfile/home/rel/build/storagegrid -t kgregory "$@"
  rc=$?
  send_build_message $rc "$2"
  return $rc
}


function send_build_message {
  local build_result=$1
  case "$build_result" in
    0|2)
      local message="Build finished sucessfully"
      local icon="/usr/share/icons/Humanity/actions/48/gtk-ok.svg"
      ;;
    1)
      local message="Build Failed"
      local icon="/usr/share/icons/Humanity/actions/48/gtk-cancel.svg"
      ;;
    3)
      local message="Build arguement error"
      local icon="/usr/share/icons/Humanity/actions/48/gtk-cancel.svg"
      ;;
    *)
      local message="Build finished"
      ;;
  esac

  notify-send "$message" "Component $2" -i "$icon"
}


function DIRS_f() {
 echo $@
}

# P4 stuff
export P4PORT=perforce.vtc.eng.netapp.com:1666
export P4USER=rel

function xml_replace {
    find . -name "*.xml" -exec sed -i "s/$1/$2/g" '{}' \;
}
