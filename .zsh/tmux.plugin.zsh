source $ZSH/plugins/tmux/tmux.plugin.zsh

if [ $TMUX ];
then
    [[ -n "$ZSH_TMUX_AUTORENAME" ]] || ZSH_TMUX_AUTORENAME=true
    if [[ $ZSH_TMUX_AUTORENAME == "true" ]];
    then

        local -A command_titles
        command_titles[ssh]=-1
        command_titles[sudo]=2

        if [[ $_GET_PATH == '' ]]; then
            _GET_PATH='echo $PWD | sed "s/^\/Users\//~/;s/^\/home\//~/;s/^~$USER/~/"'
        fi

        # called by zsh before executing a command
        function preexec()
        {
            if [[ $ZSH_TMUX_AUTORENAME != "true" ]]; then
                return
            fi
            local -a cmd; cmd=(${(z)1}) # the command string
            index=$command_titles[$cmd[1]]
            title=$cmd[1]
            if [ $index ]; then
                title=$cmd[$index]
            fi
            tmux rename-window $title
        }

        # called by zsh before showing the prompt
        function precmd()
        {
            if [[ $ZSH_TMUX_AUTORENAME != "true" ]]; then
                return
            fi
            _path=$(eval $_GET_PATH)
            tmux rename-window $_path
        }
    fi
fi