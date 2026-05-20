# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/bin:/usr/local/bin:$PATH
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export PATH=$HOME/.cargo/bin:$PATH
export GOPATH=~/go/
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:~/.dotbare

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export TERM=xterm-256color
export KUBECONFIG=$HOME/.kube/config
export EDITOR='nvim'
export MOZ_ENABLE_WAYLAND=1
export BROWSER=librewolf
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"


plugins=(git systemd)

source $ZSH/oh-my-zsh.sh
# Initialize zoxide for Zsh
eval "$(zoxide init zsh)"
# User configuration


# the 2 are for ghostty
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

bindkey "^M" accept-line
bindkey "^J" accept-line


alias vim='nvim'
alias v='nvim'
alias ts='tailscale'
alias em='emacs -nw'
alias vi='nvim'

alias ts='tailscale'
alias ll='eza -lh --icons --group-directories-first'    # long list
alias l='eza -la --icons --group-directories-first'    # show hidden files
alias ls='eza  --icons --group-directories-first'    # show hidden files
alias lt='eza -T --icons'                               # tree view
alias dotbare="$HOME/.dotbare/dotbare"

fn() { ${EDITOR:-nvim} $(rg -n '.*' "$HOME/personal/slipbox" | fzf --layout=reverse --height 50% --ansi | sed -E 's/(.*):([0-9]+):.*/\1 +\2/g'); }

alias gs='git status'
alias k='kubectl'


paste_from_clipboard() { LBUFFER+=$(wl-paste); }
zle -N paste_from_clipboard
bindkey -M viins '^P' paste_from_clipboard

export XDG_CURRENT_DESKTOP=sway
XDG_SESSION_TYPE=wayland
#eval "$(oh-my-posh init zsh)"
# eval "$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/wholespace.omp.json)"
bindkey -v
export LS_COLORS="di=38;2;135;206;250"

export DOTBARE_DIR="$HOME/.cfg"
export DOTBARE_TREE="$HOME"
alias dotbare='git --git-dir=$DOTBARE_DIR --work-tree=$DOTBARE_TREE'

alias db="dotbare"
