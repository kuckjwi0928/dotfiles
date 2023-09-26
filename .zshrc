# Homebrew
eval $(/opt/homebrew/bin/brew shellenv)

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "$HOME/.oh-my-zsh/oh-my-zsh.sh"
plug "$HOME/.oh-my-zsh/plugins/git"
plug "$HOME/.oh-my-zsh/plugins/gitfast"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "romkatv/powerlevel10k"
plug "zap-zsh/exa"
plug "$HOME/zsh/alias.zsh"
plug "$HOME/zsh/export.zsh"
plug "$HOME/zsh/function.zsh"
plug "$HOME/zsh/setup.zsh"

# Load and initialise completion system
autoload -Uz compinit
compinit
