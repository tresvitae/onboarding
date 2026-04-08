# macOS Onboarding Guide

This guide bootstraps a fresh macOS machine for DevOps and cloud development.
All steps are designed to be repeatable and safe to rerun.

## Scope

- macOS 14+ (Sonoma or newer)
- zsh shell
- Homebrew-based package management

## 1. Verify OS and CPU architecture

```bash
sw_vers
uname -m  # arm64 or x86_64
```

## 2. Install Apple developer tools

```bash
xcode-select -p >/dev/null 2>&1 || xcode-select --install
```

Optional system updates:

```bash
softwareupdate --install --all
```

## 3. Install and initialize Homebrew

```bash
if ! command -v brew >/dev/null 2>&1; then
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ "$(uname -m)" == "arm64" ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
	grep -q '/opt/homebrew/bin/brew shellenv' ~/.zprofile || echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
else
	eval "$(/usr/local/bin/brew shellenv)"
	grep -q '/usr/local/bin/brew shellenv' ~/.zprofile || echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
fi

brew update
brew upgrade
brew cleanup
```

## 4. Install core tooling

```bash
brew install awscli kubectl helm terraform jq fzf tree htop openjdk@21
brew install --cask iterm2 font-meslo-lg-nerd-font
```

Pick one container runtime:

```bash
# Docker Desktop
brew install --cask docker

# OR lightweight alternative (Colima)
brew install colima docker docker-compose
colima start
docker context use colima
```

## 5. Install kubectl plugin manager (krew)

```bash
(
	set -euo pipefail
	cd "$(mktemp -d)"
	OS="$(uname | tr '[:upper:]' '[:lower:]')"
	ARCH="$(uname -m)"
	case "${ARCH}" in
		x86_64) ARCH=amd64 ;;
		arm64|aarch64) ARCH=arm64 ;;
	esac
	KREW="krew-${OS}_${ARCH}"
	curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz"
	tar zxf "${KREW}.tar.gz"
	./${KREW} install krew
)

grep -q 'KREW_ROOT' ~/.zshrc || echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >> ~/.zshrc
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

kubectl krew install ctx ns
```

## 6. Configure zsh, plugins, and prompt

Install Oh My Zsh:

```bash
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
	RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
```

Install plugins and theme:

```bash
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

[[ -d "${ZSH_CUSTOM}/plugins/z" ]] || git clone --depth=1 https://github.com/rupa/z.git "${ZSH_CUSTOM}/plugins/z"
[[ -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]] || git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
[[ -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]] || git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
[[ -d "${ZSH_CUSTOM}/themes/powerlevel10k" ]] || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"

"$(brew --prefix)/opt/fzf/install" --all --no-bash --no-fish
```

Update `~/.zshrc` (merge with existing values if already customized):

```zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git z kubectl terraform aws fzf zsh-autosuggestions zsh-syntax-highlighting)
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export JAVA_HOME="$(brew --prefix)/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"
```

Then run prompt setup:

```bash
p10k configure
```

## 7. Optional: Node.js with nvm

```bash
if [[ ! -d "$HOME/.nvm" ]]; then
	curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

nvm install --lts
node --version
npm --version
```

## 8. Post-setup validation

```bash
command -v brew kubectl helm terraform aws java jq fzf
kubectl version --client
helm version --short
terraform version
aws --version
java -version

time zsh -i -c exit
zsh -n ~/.zshrc

kubectl config current-context
kubectl ctx || true
kubectl ns || true
```

Security hardening:

```bash
chmod 600 ~/.zshrc 2>/dev/null || true
chmod 600 ~/.kube/config 2>/dev/null || true
chmod 600 ~/.aws/config 2>/dev/null || true
git config --global credential.helper osxkeychain
```

## Troubleshooting

- If `brew` is not found, run `source ~/.zprofile`.
- If `kubectl krew` is not found, open a new terminal or run `source ~/.zshrc`.
- If `docker` fails with Colima, run `colima status` and `colima start`.
- If shell startup is slow, profile with `zsh -i -c 'zmodload zsh/zprof; zprof'`.