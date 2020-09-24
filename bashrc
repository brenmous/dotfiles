# .bashrc

# Source global definitions
if [ -f /etc/skel/.bashrc ]; then
	. /etc/skel/.bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# Prompt
. /etc/bash_completion.d/git-prompt
VIRTUAL_ENV_DISABLE_PROMPT=1
force_color_prompt=yes

## Venv function
function virtualenv_info(){ 
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv="${VIRTUAL_ENV##*/}"
    else
        venv=''
    fi
    [[ -n "$venv" ]] && echo "{$venv}"
}

# Green + pink PS1 with git prompt
# export PS1='\[\033[0;32m\]\[\033[0m\033[1;32m\]\u:\[\033[0;35m\]\w\[\033[0;35m\]$(__git_ps1)\n\[\033[0;32m\]\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;37m\] '

# Pink + blue PS1 with git prompt + clock
export PS1="\[\033[38;5;132m\]\u:\[$(tput sgr0)\]\[\033[38;5;26m\]\w\[$(tput sgr0)\]\[\033[38;5;26m\]\$(__git_ps1)\[$(tput sgr0)\] \[\033[38;5;26m\]\$(virtualenv_info)\[$(tput sgr0)\]\n\[$(tput sgr0)\]\[\033[38;5;132m\][\t]\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;132m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"


export PATH=$PATH:'/usr/local/bin'

export TERM=xterm-256color

# Editor preference
export VISUAL=nvim
export EDITOR="$VISUAL"

# MTPy dev vars
export GDAL_DATA=/usr/share/gdal/2.2
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal

# Detcap dev vars
#export PROC_HOST_NAME=localhost
#export PROC_MYSQL_SC3_USER=sysop
#export PROC_MYSQL_SC3_PASSWORD=sysop
#export SEISCOMP_RDS_ENDPOINT=localhost
#export SEISCOMP_MACHINE_NUMBER=standalone
#export SEISCOMP_PROC_MACHINE_NUMBER=standalone
#export DETCAP_FDSN_URL=http://localhost:8081
#export DETCAP_LOG_LEVEL=DEBUG
#export QUAKELINK_HOST_NAME=localhost

# UncoverML dev vars
# export UNCOVERML_SRC=$HOME/uncover-ml

export PATH=$PATH:/usr/bin:/usr/local/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:/usr/local/lib
# Add GMT to path
export PATH=/usr/local/gmt/bin:$PATH
