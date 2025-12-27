# Fish shell configuration

# XDG Base Directory
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache

# Homebrew (Apple Silicon)
if test -d /opt/homebrew
    eval (/opt/homebrew/bin/brew shellenv)
end
mise activate fish | source
