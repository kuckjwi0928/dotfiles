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
alias gradle-lock-clear="find ~/.gradle -type f -name '*.lock' -delete"
alias ls="exa"
alias lssh="$HOME/zsh/lssh.conf.template.sh && lssh"
alias git="git-branchless wrap --"
alias gsw="git sw"
alias dive="docker run --rm -it \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v  "$(pwd)":"$(pwd)" \
      -w "$(pwd)" \
      wagoodman/dive:latest"
