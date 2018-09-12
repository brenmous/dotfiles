alias pdf=evince

# aliases for aws CLI
alias atwsdev="export AWS_PROFILE=atwstest"
alias atwsprod="export AWS_PROFILE=atwsprod"
alias atwsdocker="export AWS_PROFILE=atwsdocker"
alias atwsproduser="export AWS_PROFILE=atwsproduser"

# cleanup pyc files under the current folder
alias rmpyc='find . -name "*.pyc" -exec rm {} +'

# start/stop ssh-agent if needed
#function trap_exit {
#    if [[ -n $SSH_AGENT_PID ]]; then
#        kill $SSH_AGENT_PID
#    fi
#}
#if [[ -z $SSH_AGENT_PID ]]; then
#    eval "$(ssh-agent -s)"
#    trap trap_exit EXIT
    ssh-add ~/.ssh/eatws-prod.pem > /dev/null 2>&1 
    ssh-add ~/.ssh/eatws-test.pem > /dev/null 2>&1 
    ssh-add ~/.ssh/simon-knapp-test.pem > /dev/null 2>&1
    ssh-add ~/.ssh/simon-knapp-prod.pem > /dev/null 2>&1
#    ssh-add
#else
#    echo 'ssh-agent already running.'
#fi


# added by Miniconda2 installer
#export PATH="/home/simon/miniconda2/bin:$PATH"
