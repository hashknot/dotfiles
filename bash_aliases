if [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    alias ls='ls -1GF'
    alias sl='ls -lGF'
    alias ll='ls -hltGF'
    alias la='ls -ahltGF'
    alias displayoff='pmset displaysleepnow'
    alias pyc='find . -type f -name \*.pyc -delete'
else
    # Linux
    alias ls='ls -1 --color=auto'
    alias sl='ls -l --color=auto'
    alias ll='ls -hlt --color=auto'
    alias la='ls -ahlt --color=auto'
    alias pyc='pyclean .'
fi
alias reboot='sudo reboot'
alias poweroff='sudo poweroff'
alias shutdown='sudo shutdown'
alias bandkar='xset dpms force off'
alias pdflatex='pdflatex --interaction batchmode'
alias vim='vim -p '
alias vimo='vim -O '
alias v=vim
alias more='less'
alias wget='wget -c '
alias screens='screen -ls'
alias screenS='screen -S'
alias echo='echo -e '
alias clipboard='xclip -selection "clipboard" -o'
alias ..='cd ..'
alias ...='cd ../..'
alias ....=' cd ../../..'
alias xc='xclip -selection clipboard -i '
alias ports='netstat -tlnp | column -t '
alias xo='exo-open '
alias df='df -h '
alias py='python '
alias py3='python3 '
alias repoClean='repo forall -c "git clean -dfx" -p'
alias gut='git'
alias cd..='cd ..'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias rm=\rm
alias gs='g s'
alias gl='g l'
alias grep='grep --color=auto'
alias _='sudo'
alias tl='tmux list-sessions'
alias ta='tmux attach-session -t'

alias txc='latexmk -c'
alias txpdf='latexmk -quiet -f -pdf'
alias txpvc='latexmk -pvc'

alias ejectdrive='sudo udisksctl power-off --block-device'

function define() {
    wn $1 -over
}

function ghclone() {
    git clone "https://github.com/$1"
}

alias matlabcli='matlab -nodesktop -nosplash'
alias aptupdate='sudo apt-get update'
alias aptupgrade='sudo apt-get upgrade'
alias aptinstall='sudo apt-get install'
alias dfh='df -h -t ext2 -t ext3 -t ext4 -t ntfs'

function caps2esc() {
    sudo loadkeys =(echo "keymaps 0-127\nkeycode 58 = Escape")
}

alias soundreset='pacmd unload-module module-udev-detect && pacmd load-module module-udev-detect'
alias vertscroll='synclient VertScrollDelta=-114'
