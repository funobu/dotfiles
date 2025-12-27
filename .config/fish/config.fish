# Fish shell configuration

# aliases
alias g git
alias ga "git add"
alias gc "git commit -m"
alias lg "lazygit"
alias c claude
alias cy "claude --dangerously-skip-permissions"
command -qv nvim && alias vim nvim

# XDG Base Directory
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx EDITOR nvim

# Homebrew (Apple Silicon)
if test -d /opt/homebrew
    eval (/opt/homebrew/bin/brew shellenv)
end
mise activate fish | source
