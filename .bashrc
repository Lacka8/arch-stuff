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
  local exit_status=$?						# Get command exit status
  if [[ $exit_status == 0 ]]; then				# On success
    local status_color='\e[32m'					# Green color
  elif [[ $exit_status == 126  || $exit_status == 127 ]]; then	# On typo or missing command
    local status_color='\e[33m'					# Orange-ish color
  elif [[ $exit_status == 130 ]]; then				# On Ctrl-C
    local status_color='\e[94m'					# Blue color
  else								# Rest of the cases
    local status_color='\e[31m'					# Red color
  fi
  local owner=$(ls -ld | awk '{print $3}')			# Get owner of current dir
  if [ "$owner" == $USER ] ; then				# If the owner is the user 
    local path_color='\e[37m'					# White color
  elif [ "$owner" == "root" ] ; then				# If owner is root
    local path_color='\e[34m'					# Red color
  else								# Owner is other user
    local path_color='\e[35m' 					# Magenta Color
  fi
  local top_right=$USER'@'$HOSTNAME
  PS1="\[\e7\e[${LINES}A\e[$( expr $COLUMNS - length $top_right)C\e[7m${top_right}\e8\]"
  PS1+="\[${status_color}\][\[${path_color}\]\W\[$status_color\]]"
  # PS1+="${git_output}"
  PS1+="\[\e[0m\] \$ "
}

export PROMPT_COMMAND=prompt_command

# PS1='[\u@\h \W]\$'
