eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"
eval "$(fasd --init auto)"

source <(kubectl completion zsh)
source ~/.p10k.zsh
