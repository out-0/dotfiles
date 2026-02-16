fastfetch
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi



# ---  PATHS & CORE ---
#export PATH="$HOME/.local/bin:$HOME/miniconda3/bin:$PATH"
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH"
export PATH="$HOME/.local/pycharm-2025.3.1.1/bin/:$PATH"

# --- COMPLETIONS & HISTORY ---
autoload -Uz compinit && compinit -u
HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups \
       hist_save_no_dups hist_ignore_dups hist_find_no_dups



# --- ZINIT SETUP (Plugin Manager) ---
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Silence zinit and compinit noise
source "${ZINIT_HOME}/zinit.zsh" > /dev/null 2>&1
autoload -Uz add-zsh-hook # Move this up here

# Plugins
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit cdreplay -q
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Styles
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons=always --color=always $realpath'

# --- 4. ALIASES ---

# Navigation & Listing (Using eza)
alias ..='cd ..'
alias l='eza -lh --icons=auto'
alias ls='eza -lha --icons=auto --group-directories-first'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias c='clear'

# Essentials
alias c='clear'
alias cls='clear'
alias e='exit'
alias vim='nvim'
alias v='nvim'
alias py='python3'
alias grep='rg --color=auto'
alias lg='lazygit'
alias killall='killall -9 zsh'
alias pycharm='pycharm & disown'
alias ai='opencode'
# Git
alias gac='git add . && git commit -m'
alias gs='git status'
alias gp='git push'

# --- 5. SHELL INTEGRATIONS ---
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
# eval "$(starship init zsh)"


#~/dotfiles/change_kitty_themes.sh

# opencode
export PATH=/home/out/.opencode/bin:$PATH


# For python specific version
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# python environement Initialization
eval "$(pyenv init - --no-rehash)" > /dev/null 2>&1



alias as='codex'


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



