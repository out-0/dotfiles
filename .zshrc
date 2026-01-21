# --- 1. PATHS & CORE ---
export PATH="$HOME/.local/bin:$HOME/miniconda3/bin:$PATH"

# --- 2. ZINIT SETUP (Plugin Manager) ---
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit cdreplay -q

# --- 3. COMPLETIONS & HISTORY ---
autoload -Uz compinit && compinit
HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups \
       hist_save_no_dups hist_ignore_dups hist_find_no_dups

# Styles
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons=always --color=always $realpath'

# --- 4. ALIASES ---

# Navigation & Listing (Using eza)
alias ..='cd ..'
alias ls='eza -ha --icons=auto --group-directories-first'
alias ll='eza -lha --icons=auto --group-directories-first'
alias tree='eza --tree --icons=auto'

# Essentials
alias c='clear'
alias cls='clear'
alias e='exit'
alias vim='nvim'
alias v='nvim'
alias py='python3'
alias grep='rg --color=auto'
alias lg='lazygit'

# Git
alias gac='git add . && git commit -m'
alias gs='git status'
alias gp='git push'

alias setup-school='~/school-config/init_goinfre.sh'

# --- 5. SHELL INTEGRATIONS ---
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

# Launch Fastfetch on start
[[ -f $(command -v fastfetch) ]] && fastfetch
