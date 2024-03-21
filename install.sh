#!/bin/bash
/bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/bin/bash -c "$(curl -sSL https://get.rvm.io | bash -s stable --ruby)"
/bin/bash -c "$(curl -L -o pkl https://github.com/apple/pkl/releases/download/0.25.1/pkl-linux-aarch64 chmod +x pkl)"

/bin/bash -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew bundle

curl -fsSL https://raw.githubusercontent.com/yusufcanb/tlm/release/1.1/install.sh | sudo bash -E

git config --global core.editor "nvim"
git config --global core.pager "delta"
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate "true"
git config --global delta.line-numbers "true"
git config --global delta.hyperlinks "true"
git config --global delta.side-by-side "true"
git config --global merge.conflictstyle "diff3"
git config --global diff.colorMoved "default"

(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)

kubectl krew install view-secret
kubectl krew install sniff
kubectl krew install tree
kubectl krew install access-matrix
kubectl krew install stern
kubectl krew install resource-capacity

mkdir -p $HOME/.config && cp -R ./nvim $HOME/.config
mkdir -p $HOME/.aws && cp -R ./aws $HOME/.aws
cp -R ./zsh .p10k.zsh .zshrc .curlrc $HOME

kubectl completion zsh > $HOME/.local/share/zap/completion/_kubectl
helm completion zsh > $HOME/.local/share/zap/completion/_helm
kaf completion zsh > $HOME/.local/share/zap/completion/_kaf
ln -s /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm $HOME/.local/share/zap/completion/_nvm

source ~/.nvm/nvm.sh

nvm install --lts
npm install -g @bchatard/alfred-jetbrains

chmod +x pkl
sudo mv pkl /usr/local/bin
