export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$HOME/.cargo/bin:${KREW_ROOT:-$HOME/.krew}/bin:$(go env GOPATH)/bin:$PATH"
export KUBE_EDITOR="/opt/homebrew/bin/nvim"
export DRACULA_DISPLAY_FULL_CWD=1
