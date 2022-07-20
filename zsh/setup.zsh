PROMPT='$(kube_ps1)'$PROMPT

eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"
eval "$(fasd --init auto)"

source /opt/homebrew/opt/kube-ps1/share/kube-ps1.sh
source <(kubectl completion zsh)
