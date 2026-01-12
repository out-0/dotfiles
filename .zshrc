export PATH="$PATH:/home/out/.local/bin"
export PATH="$PATH:/home/out/.local/bin/"
export PATH="$PATH:~/.local/bin/"

# ---------------------------
# Zinit setup
# ---------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# ---------------------------
# Completion system
# ---------------------------
autoload -Uz compinit && compinit

# ---------------------------
# Plugins via zinit
# ---------------------------
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo

zinit cdreplay -q

# ---------------------------
# Keybindings
# ---------------------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# ---------------------------
# History config
# ---------------------------
HISTSIZE=500000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups \
       hist_save_no_dups hist_ignore_dups hist_find_no_dups

# ---------------------------
# Completion styling
# ---------------------------
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza $realpath'

# ---------------------------
# Directory shortcuts (aliases)
# ---------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# ---------------------------
# Core utility aliases
# ---------------------------
alias l='eza -lh --icons=auto'
alias ls='eza -lia --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias mkdir='mkdir -p'
alias tree='tree -a -I .git'
#alias cat='bat'
alias c='clear'
alias e='exit'
alias vim='nvim'
alias v='nvim'
alias grep='rg --color=auto'
alias ssn='sudo shutdown now'
alias srn='sudo reboot now'
alias pdf='evince'
alias open= 'ranger'
alias wifi= 'nm-applet --indicator'

# ---------------------------
# Git aliases
# ---------------------------
alias gac='git add . && git commit -m'
alias gs='git status'
alias gpush='git push origin'
alias lg='lazygit'

# ---------------------------
# NixOS aliases
# ---------------------------
alias rebuild='sudo nixos-rebuild switch --flake ~/ayoub/.#default'
alias recats='sudo nix flake lock --update-input nixCats && sudo nixos-rebuild switch --flake ~/ayoub/.#default'

# ---------------------------
# Downloads aliases
# ---------------------------
alias yd='yt-dlp -f "bestvideo+bestaudio" --embed-chapters --external-downloader aria2c --concurrent-fragments 8 --throttled-rate 100K'
alias td='yt-dlp --external-downloader aria2c -o "%(title)s."'
alias download='aria2c --split=16 --max-connection-per-server=16 --timeout=600 --max-download-limit=10M --file-allocation=none'

# ---------------------------
# VPN aliases
# ---------------------------
alias vu='sudo tailscale up --exit-node=raspberrypi --accept-routes'
alias vd='sudo tailscale down'

warp () {
    sudo systemctl "$1" warp-svc
}

# ---------------------------
# Other useful aliases
# ---------------------------
alias apps-space='expac -H M "%011m\t%-20n\t%10d" $(comm -23 <(pacman -Qqe | sort) <(pacman -Qqg base base-devel | sort)) | sort -n'
alias files-space='sudo ncdu --exclude /.snapshots /'
alias ld='lazydocker'
alias docker-clean='docker container prune -f && docker image prune -f && docker network prune -f && docker volume prune -f'
alias crdown='mpv --yt-dlp-raw-options=cookies-from-browser=brave'
alias cr='cargo run'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT1'
alias y='yazi'

lsfind() {
    ll "$1" | grep "$2"
}

# ---------------------------
# Clipboard aliases (Wayland)
# ---------------------------
alias pbcopy='wl-copy'
alias pbpaste='wl-paste'

# ---------------------------
# Shell integrations
# nice thing
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

alias py='clear; python3'


# Hyprland Rotation Aliases
#alias flip-right="hyprctl keyword monitor eDP-1, transform, 1"
#alias flip-left="hyprctl keyword monitor eDP-1, transform, 3"
alias rotateinverted="hyprctl keyword monitor eDP-1, transform, 2"
alias rotatenormal="hyprctl keyword monitor eDP-1, transform, 0"
