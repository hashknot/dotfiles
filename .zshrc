export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM="xterm-256color"
[ $SCREEN ] && export TERM="screen-256color"

if [ ! $SCREEN ]; then
    screen
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.zsh

ZSH_THEME="crusador"

# CASE_SENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# DISABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# oh-my-zsh plugins
plugins=(git extract django command-not-found repo screen lol rsync colorize)

source $ZSH/oh-my-zsh.sh

if [ -f ~/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi

if [ -f ~/.zshrc_local ]; then
    source $HOME/.zshrc_local
fi
