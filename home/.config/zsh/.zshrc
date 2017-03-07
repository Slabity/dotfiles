# ZSH Variables
export ZSH=$ZDOTDIR/oh-my-zsh
ZSH_THEME="powerlevel9k/powerlevel9k"
UPDATE_ZSH_DAYS=7
HIST_STAMPS="mm-dd-yyyy"
HISTFILE=$ZDOTDIR/zsh_history
COMPLETION_WAITING_DOTS="true"
ZSH_COMPDUMP=$ZDOTDIR/zcompdump

# Plugins
plugins=(common-aliases compleat git git-extras sudo systemd tmux vi-mode wd)

ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOCONNECT=false

# Export local path
export PATH="$HOME/.local/bin:$PATH:/sbin:/usr/sbin"
source $HOME/.local/share/scripts/utils.sh

# Good aliases
alias sudo="sudo env PATH=$PATH"

# Finally, source oh-my-zsh
source $ZSH/oh-my-zsh.sh

