# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Oh My Zsh + DevOps Setup (Optimized for macOS M-series)

export ZSH="${HOME}/.oh-my-zsh"

# Env Vars
export EDITOR=vim
export KUBE_EDITOR=vim
export AWS_CLI_AUTO_PROMPT=off  # Security: Hide creds in prompt
export GOPATH="${HOME}/go"
export KUBECONFIG=~/.kube/config

# PATH: Consolidated (Homebrew first, then tools/user)
eval "$(/opt/homebrew/bin/brew shellenv)"  # Adds /opt/homebrew/bin
export PATH="${PATH}:${HOME}/.krew/bin:${HOME}/bin:/usr/local/bin"
export PATH="/opt/homebrew/opt/node@22/bin:${PATH}"  # Node-specific
export PATH="${HOME}/.antigravity/antigravity/bin:${PATH}"

# Java (detects 21)
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
export PATH="${JAVA_HOME}/bin:${PATH}"

# NVM (lazy-load only if needed)
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" && -n "$(command -v node 2>/dev/null)" ]] && \. "$NVM_DIR/nvm.sh"

# History (increased for better auditing)
HISTSIZE=20000
SAVEHIST=20000
setopt SHARE_HISTORY APPEND_HISTORY HIST_IGNORE_DUPS

# Plugins (your selection + z for dir jumping)
plugins=(
  zsh-z zsh-autosuggestions zsh-syntax-highlighting
  aws git brew docker docker-compose gradle terraform fzf
)

# Theme: Powerlevel10k recommended (fast git/AWS status)
ZSH_THEME="powerlevel10k/powerlevel10k"

# Source OMZ + completions (once only)
source $ZSH/oh-my-zsh.sh
autoload -Uz compinit && compinit  # Edge: Suppresses warnings
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform  # Homebrew path

# Fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Aliases (yours + security tweaks)
alias vi='nvim' modvim='nvim ~/.config/nvim/init.vim'
alias sshconfig='cat ~/.ssh/config' modssh='nvim ~/.ssh/config'
alias modzsh='nvim ~/.zshrc' modalias='nvim ~/.zsh/aliases.zsh'
alias hosts='ansible-inventory --graph' grep='grep --color=auto -i'
alias pip='pip3' python='python3' aztfy='aztfexport'

# Kubernetes/Helm (your faves)
alias k='kubectl' h='helm' ctx='kubectx' ns='kubens'
alias contexts='kubectl config get-contexts'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Reload: source ~/.zshrc
