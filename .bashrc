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
  PS1='\[\e[0m' 						# Reset text formatting and start noadvancing block
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
  local git_output=''
  exec 6>&2 2> /dev/null
  git status -s 1> /dev/null
  if [[ $? == 0 ]] ; then
    local fetch_needed=$(git fetch --dry-run)
    local unstaged=$(git ls-files -o -m --exclude-standard)
    git diff --quiet HEAD
    local uncommited=$?
    local unpushed=$(git log --branches --not --remotes)
    if [[ ${#fetch_needed} > 0 ]] ; then 
      git_output+='\e[35m'
    elif [[ ${#unstaged} > 0 ]] ; then
      git_output+='\e[31m'
    elif [[ $uncommited != 0 ]] ; then
      git_output+='\e[33m'
    elif [[ ${#unpushed} > 0 ]] ; then
      git_output+='\e[34m'
    else
      git_output+='\e[32m'
    fi
    git_output+=' ('$(basename $(git rev-parse --show-toplevel))':'$(git rev-parse --abbrev-ref HEAD)')'
  fi
  exec 2>&6
  local top_right=$USER'@'$HOSTNAME				# Username@Hostname
  PS1+='\e7'							# Save cursor position
  PS1+='\e['$LINES'A'						# Move cursor to top of the screne
  PS1+='\e['$( expr $COLUMNS - length $top_right)'C'		# Move cursor to 'almost' end of line 
  PS1+='\e[7m'							# Invert colors
  PS1+=$top_right
  PS1+='\e8'							# Load cursor position
  PS1+=$status_color
  PS1+='\][\['
  PS1+=$path_color
  PS1+='\]\W\['							# Working directory
  PS1+='\e[39m'
  PS1+=$status_color
  PS1+='\]]\['
  PS1+='\e[0m\]'						# Default formatting
  PS1+=$git_output
  PS1+='\[\e[0m'						# Default formatting
  PS1+='\] \$ '							# Print $
}

export PROMPT_COMMAND=prompt_command

# PS1='[\u@\h \W]\$'
