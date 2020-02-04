# .bashrc

# Source global definitions
if [ -f /etc/skel/.bashrc ]; then
	. /etc/skel/.bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# Activate _git_ps1
. /etc/bash_completion.d/git-prompt
export PS1='\[\033[0;32m\]\[\033[0m\033[1;32m\]\u:\[\033[0;35m\]\w\[\033[0;35m\]$(__git_ps1)\n\[\033[0;32m\]\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;37m\] '

export PATH=$PATH:'/usr/local/bin'

# Editor preference
export VISUAL=vim
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
