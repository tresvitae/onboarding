# Step-by-Step

sw_vers  # macOS 14+?
uname -m  # arm64 (M-series)?

# Xcode tools (git/make)
xcode-select --install  # Or `softwareupdate --install --all`

# Homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update && brew upgrade && brew cleanup


# Terminal + Editor
brew install --cask iterm2 neovim

# DevOps CLI
brew install awscli@2 kubectl helm terraform jq fzf tree htop
brew install --cask docker  # Or colima/lima for lighter

# Krew (kubectl plugins)
curl https://krew.sh/docs/user_guide/setup/ | bash
kubectl krew install ctx ns  # kubectx/kubens

# Java 21
brew install openjdk@21

# CLI staples
brew install awscli@2 kubectl helm terraform jq fzf tree htop

# Extras (if used)
brew install ansible node@22  # aztfy, nvm


---


# ZSH + OMZ


# OMZ 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

# Key plugins (
mkdir -p $ZSH/custom/plugins
cd $ZSH/custom/plugins
git clone https://github.com/rupa/z.git zsh-z
git clone https://github.com/zsh-users/zsh-autosuggestions .
git clone https://github.com/zsh-users/zsh-syntax-highlighting .
git clone https://github.com/junegunn/fzf.git ~/.fzf  # Shell integration

# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Plugins
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
mkdir -p ${ZSH_CUSTOM}/themes
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k


# Fonts for P10k
brew install --cask font-meslo-lg-nerd-font

p10k configure

Choose Unicode for Powerlevel10k configuration on macOS—it's the recommended default for richer visuals like git icons (branch ➤, staged ●), K8s context (☸), and AWS profile without cluttering space.


---
Post-Setup Validation

# Test startup time (<200ms goal)
time zsh -i -c exit

# Security audit
zsh -n ~/.zshrc  # Syntax
alias | grep -E 'k|tf|aws'  # Key aliases
kubectl config view --minify  # Kube safe?

k ctx  # Aliases work?
echo $JAVA_HOME  # /Library/Java/.../21


# Secyruty
chmod 600 ~/.zshrc ~/.kube/config ~/.aws/config
git config --global credential.helper osxkeychain

---