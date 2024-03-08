eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"
eval "$(fasd --init auto)"

[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "$HOME/.p10k.zsh" ] && \. "$HOME/.p10k.zsh"
