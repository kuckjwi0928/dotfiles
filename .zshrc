# Homebrew
eval $(/opt/homebrew/bin/brew shellenv)

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "$HOME/zsh/alias.zsh"
plug "$HOME/zsh/export.zsh"
plug "$HOME/zsh/setup.zsh"
plug "$ZSH/oh-my-zsh.sh"
plug "$ZSH/plugins/git"
plug "$ZSH/plugins/gitfast"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "romkatv/powerlevel10k"
plug "zap-zsh/exa"

# Load and initialise completion system
autoload -Uz compinit
compinit
