PROMPT='$(kube_ps1)'$PROMPT

eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"
eval "$(fasd --init auto)"

source <(kubectl completion zsh)
