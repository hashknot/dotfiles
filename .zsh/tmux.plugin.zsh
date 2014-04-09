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
            local title
            local -a cmd; cmd=(${(z)1}) # the command string
            index=$command_titles[$cmd[1]]
            title=$cmd[1]
            if [ $index ]; then
                title=$cmd[$index]
            fi
            if [ ${#title} -gt 25 ]; then
                title="..$(echo $title | tail -c 25)"
            fi
            tmux rename-window $title
        }

        # called by zsh before showing the prompt
        function precmd()
        {
            if [[ $ZSH_TMUX_AUTORENAME != "true" ]]; then
                return
            fi
            local title
            title="$(eval $_GET_PATH)"
            if [ ${#title} -gt 25 ]; then
                title="..$(echo $title | tail -c 25)"
            fi
            tmux rename-window $title
        }
    fi
fi
