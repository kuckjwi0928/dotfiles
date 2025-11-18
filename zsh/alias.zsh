alias vi="nvim"
alias cat="bat"
alias top="htop"
alias watch="viddy "
alias a='fasd -a'
alias s='fasd -si'
alias d='fasd -d'
alias f='fasd -f'
alias sd='fasd -sid'
alias sf='fasd -sif'
alias z='fasd_cd -d'
alias zz='fasd_cd -d -i'
alias tf="terraform"
alias k="kubectl"
alias lssh="$HOME/zsh/lssh.conf.template.sh && lssh"
alias gsw="git sw"

function awslocal() {
        AWS_PROFILE=localstack aws $@
}

function tflocal() {
        AWS_PROFILE=localstack terraform $@
}
