#!/bin/bash

# --- 1. CONFIGURATION ---
GOINFRE="/goinfre/$USER"
MY_APPS="$GOINFRE/apps"
LOCAL_BIN="$HOME/.local/bin"

# Create skeleton structure in Goinfre
mkdir -p "$GOINFRE" "$MY_APPS" "$LOCAL_BIN" "$GOINFRE/vscode_data" "$GOINFRE/conda" "$GOINFRE/nvim_data" "$GOINFRE/nvim_state"

echo "🚀 Starting Ultimate Goinfre Setup for $USER..."

# --- 2. VS CODE INSTALLATION ---
if [ ! -f "$MY_APPS/vscode/bin/code" ]; then
    echo "📦 VS Code not found on this iMac. Installing to Goinfre..."
    mkdir -p "$MY_APPS/vscode"
    curl -L "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64" --output "$GOINFRE/vscode.tar.gz"
    tar -xzf "$GOINFRE/vscode.tar.gz" -C "$MY_APPS/vscode" --strip-components=1
    rm "$GOINFRE/vscode.tar.gz"
fi
ln -sf "$MY_APPS/vscode/bin/code" "$LOCAL_BIN/code"

# --- 3. CONDA BRIDGE & INSTALL ---
if [ ! -d "$GOINFRE/miniconda3" ]; then
    echo "🐍 Conda not found on this iMac. Installing to Goinfre..."
    curl -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh
    bash /tmp/miniconda.sh -b -u -p "$GOINFRE/miniconda3"
    rm /tmp/miniconda.sh
    # Automatically init for ZSH after first install
    "$GOINFRE/miniconda3/bin/conda" init zsh > /dev/null
fi

# Always force the link (the portal)
ln -sf "$GOINFRE/miniconda3" "$HOME/miniconda3"

# Handle the .conda config folder (Safe Migration)
if [ ! -L "$HOME/.conda" ]; then
    echo "🐍 Linking Conda config..."
    if [ -d "$HOME/.conda" ] && [ ! -L "$HOME/.conda" ]; then
        cp -r "$HOME/.conda/." "$GOINFRE/conda/" 2>/dev/null
        rm -rf "$HOME/.conda"
    fi
    ln -s "$GOINFRE/conda" "$HOME/.conda"
fi

# --- 4. VS CODE EXTENSIONS ---
if [ ! -L "$HOME/.vscode/extensions" ]; then
    echo "🔗 Linking VS Code extensions..."
    mkdir -p "$HOME/.vscode"
    if [ -d "$HOME/.vscode/extensions" ] && [ ! -L "$HOME/.vscode/extensions" ]; then
        cp -r "$HOME/.vscode/extensions/." "$GOINFRE/vscode_data/" 2>/dev/null
        rm -rf "$HOME/.vscode/extensions"
    fi
    ln -sf "$GOINFRE/vscode_data" "$HOME/.vscode/extensions"
fi

# --- 5. NEOVIM ---
echo "🌙 Linking Neovim data & state..."

# Data Folder (Plugins, LSPs)
if [ ! -L "$HOME/.local/share/nvim" ]; then
    mkdir -p "$HOME/.local/share"
    if [ -d "$HOME/.local/share/nvim" ] && [ ! -L "$HOME/.local/share/nvim" ]; then
        cp -r "$HOME/.local/share/nvim/." "$GOINFRE/nvim_data/" 2>/dev/null
        rm -rf "$HOME/.local/share/nvim"
    fi
    ln -sf "$GOINFRE/nvim_data" "$HOME/.local/share/nvim"
fi

# State Folder (Undo history, logs)
if [ ! -L "$HOME/.local/state/nvim" ]; then
    mkdir -p "$HOME/.local/state"
    if [ -d "$HOME/.local/state/nvim" ] && [ ! -L "$HOME/.local/state/nvim" ]; then
        cp -r "$HOME/.local/state/nvim/." "$GOINFRE/nvim_state/" 2>/dev/null
        rm -rf "$HOME/.local/state/nvim"
    fi
    ln -sf "$GOINFRE/nvim_state" "$HOME/.local/state/nvim"
fi

# Background Sync (Run this every time to ensure LSPs are ready)
if [ -d "$HOME/.config/nvim" ]; then
    echo "📥 Auto-syncing Plugins and LSPs (Mason)..."
    (nvim --headless "+Lazy! sync" +qa 2>/dev/null &)
fi


# --- DISCORD HYBRID SETUP ---
echo "🎧 Optimizing Discord (Stay logged in + Save space)..."
DISCORD_HOME="$HOME/.config/discord"
DISCORD_GOINFRE="$GOINFRE/discord_cache"

# 1. Create the structure
mkdir -p "$DISCORD_HOME"
mkdir -p "$DISCORD_GOINFRE/Cache"
mkdir -p "$DISCORD_GOINFRE/Code_Cache"
mkdir -p "$DISCORD_GOINFRE/GPUCache"

# 2. Link the heavy folders specifically
# Cache
if [ ! -L "$DISCORD_HOME/Cache" ]; then
    rm -rf "$DISCORD_HOME/Cache"
    ln -sf "$DISCORD_GOINFRE/Cache" "$DISCORD_HOME/Cache"
fi

# Code Cache
if [ ! -L "$DISCORD_HOME/Code Cache" ]; then
    rm -rf "$DISCORD_HOME/Code Cache"
    ln -sf "$DISCORD_GOINFRE/Code_Cache" "$DISCORD_HOME/Code Cache"
fi

# GPU Cache
if [ ! -L "$DISCORD_HOME/GPUCache" ]; then
    rm -rf "$DISCORD_HOME/GPUCache"
    ln -sf "$DISCORD_GOINFRE/GPUCache" "$DISCORD_HOME/GPUCache"
fi




# --- 6. HOUSEKEEPING ---
echo "🧹 Cleaning temporary junk..."
rm -rf "$HOME/.cache/*"
rm -rf "$HOME/.local/share/Trash/*"
rm -rf "$HOME/.vscode-server"
rm -f "$GOINFRE/nvim_state/log"

# Force shell to remember new binaries
hash -r

echo "✅ ALL DONE! Your environment is optimized."
