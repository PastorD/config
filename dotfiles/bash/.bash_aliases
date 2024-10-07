
# basic aliasess
alias gs="git status"
alias sb="source ~/.bashrc"


# cd aliases
alias cdnewest='cd  $(ls -1dt ./*/ | head -n 1)'
alias cdoldest='cd $(ls -1dt --reverse ./*/ | head -n 1)'
alias cdlast='cd $(ls -1d ./*/ | tail -n 1)'
alias cdfirst='cd $(ls -1d ./*/ | head -n 1)'
