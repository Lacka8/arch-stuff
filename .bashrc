#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# No history size limit
HISTSIZE=
HISTFILESIZE=

# No duplicate commands saved to history
export HISTCONTROL=ignoreboth:erasedups

# Append to history instead of overwriting
# shopt -s histappend

# Try to save multiline command in one entry
shopt -s cmdhist

# Minor typos are corrected in cd
shopt -s cdspell


# Adding cargo (rust) to path
export PATH="$HOME/.cargo/bin:$PATH"

# Color definitions (taken from Color Bash Prompt HowTo).
# Some colors might look different of some terminals.
# For example, I see 'Bold Red' as 'orange' on my screen,
# hence the 'Green' 'BRed' 'Red' sequence I often use in my prompt.


# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset


ALERT=${BWhite}${On_Red} # Bold White on red background

# Set vim as default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Nano settings
alias nano='nano -AMPZabceijlm -T 2'

# Colorize the ls output
alias ls='ls -h --color=auto --group-directories-first'

# Detailed long listing with ls
alias ll='ls -lah'
alias la='ll'

# Less with clean exit and scrollback
LESS="-iwgerMFKQX --mouse --wheel-lines=4"; export LESS

# Less is more colorful
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
# export LESS_TERMCAP_so=$'\E[01;44;33m'
# export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'
export LESS_TERMCAP_ue=$'\E[0m'

# Colorize the grep output
alias grep='grep --color=auto'

# Colorize the diff output
alias diff='diff --color=auto'

# Expand aliases when using sudo
alias sudo='sudo '

# Rerun previous line with sudo
alias please='sudo $(history -p !!)'
alias pls='please'

# Some colors for easy use
# May look different in other terminals

Black=$'\e[0;30m'
Red=$'\e[0;31m'
Green=$'\e[0;32m'
Orange=$'\e[0;33m'
Blue=$'\e[0;34m'
Purple=$'\e[0;35m'
Cyan=$'\e[0;36m'
White=$'\e[0;37m'

Gray=$'\e[1;30m'
Pink=$'\e[1;31m'
LGreen=$'\e[1;32m'
Yellow=$'\e[1;33m'
LBlue=$'\e[1;34m'
Magenta=$'\e[1;35m'
LCyan=$'\e[0;36m'
Whiteish=$'\e[1;37m'

ColorReset=$'\e[m'

function status_color(){
  case $? in
    0)        echo -en $Green;; # Succesful command
    126|127)  echo -en $Yellow;;  # Command not found
    130)      echo -en $Blue;;  # Command terminated by CTRL + C
    *)        echo -en $Red;;   # Any other error
esac
}

function owner_color(){
  local owner=$(stat -c "%u" . 2> /dev/null)
  if [ $owner == $UID ] ; then  # User's dir
    echo -en $Whiteish
  elif [ $owner == 0 ] ; then   # Root dir
    echo -en $Yellow
  else                          # Other user's dir
    echo -en $Magenta
  fi
}

function git_color(){
  if git rev-parse 2> /dev/null; then
    if [[ $(git status --porcelain 2> /dev/null) ]];then
      if [[ $(git add --all --dry-run 2> /dev/null) ]] ; then
        echo -n $Red
      else
        echo -n $Orange
      fi
    else
      if [[ $git_unpushed ]]; then
        echo -n $Blue
      else
        echo -n $Green
      fi
    fi
  fi
}

if [ "$TERM" == "linux" ]
then
  PS1='\[$(status_color)\][ \u@\h \[$(owner_color)\]\W\[$(status_color)\]] \[$(git_color)\]$(git rev-parse --abbrev-ref HEAD) \[$ColorReset\]\$ '
else
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bindings/bash/powerline.sh
fi
