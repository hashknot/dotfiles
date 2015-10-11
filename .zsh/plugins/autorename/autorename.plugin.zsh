#------------------------------
# Window title
#------------------------------

[[ -n "$TMUX_TITLE_OVERFLOW_SIZE" ]] || TMUX_TITLE_OVERFLOW_SIZE=13

case $TERM in
    termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
        if [ $TMUX ]; then
            precmd () {
                title=$(print -Pn "%~")
                if [ ${#title} -gt $TMUX_TITLE_OVERFLOW_SIZE ]; then
                    title="..$(echo $title | tail -c $TMUX_TITLE_OVERFLOW_SIZE)"
                fi
                print -Pn "\033k$title\033\\"
            }
            preexec () {
                local title
                title=${1% *}
                if [ ${#title} -gt $TMUX_TITLE_OVERFLOW_SIZE ]; then
                    title="..$(echo $title | tail -c $TMUX_TITLE_OVERFLOW_SIZE)"
                fi
                print -Pn "\033k$title\033\\"
            }
        else
            precmd () {
                print -Pn "\e]0;%M: %~\a"
            }
            preexec () {
                print -Pn "\e]0;%M: $1\a"
            }
        fi
        ;;

    screen|screen-256color)
        precmd () {
            print -Pn "\e]83;title \"$1\"\a"
            print -Pn "\e]0;$TERM - (%L) %n@%M: %~\a"
        }
        preexec () {
            print -Pn "\e]83;title \"$1\"\a"
            print -Pn "\e]0;$TERM - (%L) %n@%M: %~ ($1)\a"
        }
        ;;
esac
