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

# Colorize the ls output
alias ls='ls -h --color=auto --group-directories-first'

# Detailed long listing with ls
alias ll='ls -la'

# Colorize the grep output
alias grep='grep --color=auto'

# Colorize the diff output
alias diff='diff --color=auto'

# Expand aliases when using sudo
alias sudo='sudo '

# Rerun previous line with sudo
alias please='sudo $(history -p !!)'
alias pls='please'

# Color prompt based on exit code, path and git status
function prompt_command()
{
  local exit_status=$?

  case $exit_status in
    0) 		local status_color='\e[32m';;
    126|127)	local status_color='\e[33m';;
    130)	local status_color='\e[94m';;
    *)		local status_color='\e[31m';;
  esac

  local owner=$(ls -lnd | awk '{print $3}')
  if [ $owner == $UID ] ; then
    local path_color='\e[37m'
  elif [ $owner == 0 ] ; then
    local path_color='\e[93m'
  else
    local path_color='\e[94m'
  fi

  local top_right=$USER'@'$HOSTNAME

  PS1="\[\e[0m\e7\e[${LINES}A\e[$( expr $COLUMNS - length $top_right)C\e[7m${top_right}\e8\]"

  PS1+="\[\e[0m${status_color}\][\[${path_color}\]\W\[\e[0m${status_color}\]]"

  # PS1+="${git_output}"

  PS1+="\[\e[0m\] \$ "
}

export PROMPT_COMMAND=prompt_command

# PS1='[\u@\h \W]\$'
