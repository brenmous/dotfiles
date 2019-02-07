# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# Activate _git_ps1
. /usr/share/git-core/contrib/completion/git-prompt.sh

export PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u:\[\033[0;35m\]\w\[\033[0;35m\]$(__git_ps1)\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;37m\] '
