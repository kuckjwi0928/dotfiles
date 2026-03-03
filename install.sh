#!/usr/bin/env bash

set -e
set -o pipefail

# --- Helper Functions ---
GREEN='\03++3[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

info() {
  echo -e "${YELLOW}==>${NC} ${1}"
}

success() {
  echo -e "${GREEN}==>${NC} ${1}"
}

error() {
  echo -e "${RED}==> ERROR:${NC} ${1}" >&2
}

# Ensure we are in the dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${DOTFILES_DIR}"

# --- Package Managers ---
info "Setting up Package Managers..."

if ! command -v brew &> /dev/null; then
  info "Installing Homebrew..."
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Make brew available in the current session
  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "${HOME}/.zprofile"
else
  success "Homebrew is already installed."
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ ! -d "${HOME}/.rvm" ]]; then
  info "Installing RVM..."
  bash -c "$(curl -sSL https://get.rvm.io | bash -s stable --ruby)"
else
  success "RVM is already installed."
fi

if ! command -v gvm &> /dev/null && [[ ! -s "${HOME}/.gvm/scripts/gvm" ]]; then
  info "Installing GVM..."
  bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
else
  success "GVM is already installed."
fi

# --- Brew Dependencies ---
info "Installing dependencies from Brewfile..."
brew bundle --file="${DOTFILES_DIR}/Brewfile"

# --- Zsh Framework & Plugins ---
info "Setting up Zsh environment..."
if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
  info "Installing Oh My Zsh..."
  bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  success "Oh My Zsh is already installed."
fi

if [[ ! -d "${HOME}/.local/share/zap" ]]; then
  info "Installing Zap for Zsh..."
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
else
  success "Zap is already installed."
fi

# --- Configurations ---
info "Symlinking configuration files..."

mkdir -p "${HOME}/.config"
mkdir -p "${HOME}/.aws"

ln -sfn "${DOTFILES_DIR}/nvim" "${HOME}/.config/nvim"
ln -sfn "${DOTFILES_DIR}/aws/config" "${HOME}/.aws/config" 2>/dev/null || true # In case aws directory is not tracked
ln -sfn "${DOTFILES_DIR}/aws/credentials" "${HOME}/.aws/credentials" 2>/dev/null || true
ln -sfn "${DOTFILES_DIR}/zsh" "${HOME}/zsh"
ln -sfn "${DOTFILES_DIR}/.p10k.zsh" "${HOME}/.p10k.zsh"
ln -sfn "${DOTFILES_DIR}/.zshrc" "${HOME}/.zshrc"
ln -sfn "${DOTFILES_DIR}/.curlrc" "${HOME}/.curlrc"

success "Symlinks created."

# --- Vim/Neovim ---
info "Setting up Vim-Plug..."
if [[ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" ]]; then
  curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  success "Vim-Plug is already installed."
fi

# --- Git Configuration ---
info "Configuring Git Global settings..."
git config --global core.editor "nvim"
git config --global core.pager "delta"
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate "true"
git config --global delta.line-numbers "true"
git config --global delta.hyperlinks "true"
git config --global delta.side-by-side "true"
git config --global merge.conflictstyle "diff3"
git config --global diff.colorMoved "default"

# --- Kubernetes Krew ---
info "Setting up Krew and Plugins..."
if ! command -v kubectl-krew &> /dev/null && [[ ! -d "${KREW_ROOT:-$HOME/.krew}" ]]; then
  (
    set -x; cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW="krew-${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    ./"${KREW}" install krew
  )
else
  success "Krew is already installed."
fi

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

for plugin in view-secret sniff tree access-matrix stern resource-capacity; do
  if ! kubectl krew list | grep -q "^${plugin}$"; then
    kubectl krew install "${plugin}" || error "Failed to install krew plugin: ${plugin}"
  fi
done

# --- CLI Completions (Zap Zsh) ---
info "Generating Completions..."
mkdir -p "${HOME}/.local/share/zap/completion"
command -v kubectl &> /dev/null && kubectl completion zsh > "${HOME}/.local/share/zap/completion/_kubectl" || true
command -v helm &> /dev/null && helm completion zsh > "${HOME}/.local/share/zap/completion/_helm" || true

if [[ -f "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ]]; then
  ln -sfn "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" "${HOME}/.local/share/zap/completion/_nvm"
fi

# --- NVM configurations ---
info "Setting up Node environment using NVM..."
export NVM_DIR="$HOME/.nvm"
if [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]]; then
  source "/opt/homebrew/opt/nvm/nvm.sh"
  nvm install --lts
  nvm use --lts
  
  # Check if npm package is installed before installing
  if ! npm list -g @bchatard/alfred-jetbrains >/dev/null 2>&1; then
    npm install -g @bchatard/alfred-jetbrains
  else
    success "@bchatard/alfred-jetbrains is already installed."
  fi
else
  error "NVM was not found in /opt/homebrew/opt/nvm/nvm.sh"
fi

success "Dotfiles installation completed successfully!"
