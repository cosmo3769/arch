#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /usr/share/git/completion/git-prompt.sh

alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/piyush/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
     eval "$__conda_setup"
else
     if [ -f "/home/piyush/miniconda3/etc/profile.d/conda.sh" ]; then
         . "/home/piyush/miniconda3/etc/profile.d/conda.sh"
     else
         export PATH="/home/piyush/miniconda3/bin:$PATH"
     fi
fi
unset __conda_setup
# <<< conda initialize <<<
