#!/usr/bin/env bash
set -e

cd "$(dirname $0)"

yesToAll=0
yes=0

_ask(){
    if [ $yesToAll -eq 1 ]; then
        yes=1
        return
    fi
    read -r -p "$1 [y/N]: " response
    case $response in
        [yY][eE][sS]|[yY]) 
            yes=1
            ;;
        *)
            yes=0
            ;;
    esac
}

_softlink(){
    ln -s "$(pwd)/$1" "$2"
}

_setup_bash() {
    for f in "bashrc" "bash_aliases"; do
        if [ -f "$HOME/.$f" ]; then
            mv "$HOME/.$f" "$HOME/.$f.bak" 
        fi
        _softlink "$f" "$HOME/.$f"
    done
}

_setup_git() {
    for f in "gitconfig"; do
        if [ -f "$HOME/.$f" ]; then
            mv "$HOME/.$f" "$HOME/.$f.bak" 
        fi
        _softlink "$f" "$HOME/.$f"
    done
}

_setup_screen(){
    for f in "screenrc"; do
        if [ -f "$HOME/.$f" ]; then
            mv "$HOME/.$f" "$HOME/.$f.bak" 
        fi
        _softlink "$f" "$HOME/.$f"
    done
}

_setup_tmux(){
    for f in "tmux.conf"; do
        if [ -f "$HOME/.$f" ]; then
            mv "$HOME/.$f" "$HOME/.$f.bak" 
        fi
        _softlink "$f" "$HOME/.$f"
    done
}

_setup_vim(){
    for f in "vimrc"; do
        if [ -f "$HOME/.$f" ]; then
            mv "$HOME/.$f" "$HOME/.$f.bak" 
        fi
        _softlink "$f" "$HOME/.$f"
    done
    git clone "https://github.com/VundleVim/Vundle.vim.git" "$HOME/.vim/bundle/Vundle.vim"
    echo "\n" | vim +PluginInstall +qall
}

_setup_zsh(){
    curl 'https://raw.githubusercontent.com/hashknot/prezto/master/install.zsh' | zsh
    # wget -O - 'https://raw.githubusercontent.com/hashknot/prezto/master/install.zsh' 2>/dev/null | zsh
}

if [ "-a" == "$1" -o "-a" == "$2" ]; then
    yesToAll=1
fi

if [ "-v" == "$1" -o "-v" == "$2" ]; then
    set -x
fi

if [ "-h" == "$1" ]; then
    echo "-a    Yes to all"
    echo "-v    Verbose mode"
    exit 0
fi

_ask "Do you want to setup bash?"
if [ $yes -eq 1 ]; then
    echo "Setting up bash..."
    _setup_bash
fi

_ask "Do you want to setup git?"
if [ $yes -eq 1 ]; then
    echo "Setting up git..."
    _setup_git
fi

_ask "Do you want to setup screen?"
if [ $yes -eq 1 ]; then
    echo "Setting up screen..."
    _setup_screen
fi

_ask "Do you want to setup tmux?"
if [ $yes -eq 1 ]; then
    echo "Setting up tmux..."
    _setup_tmux
fi

_ask "Do you want to setup vim?"
if [ $yes -eq 1 ]; then
    echo "Setting up vim..."
    _setup_vim
fi

_ask "Do you want to setup zsh?"
if [ $yes -eq 1 ]; then
    echo "Setting up zsh..."
    _setup_zsh
    chsh -s /bin/zsh
fi
