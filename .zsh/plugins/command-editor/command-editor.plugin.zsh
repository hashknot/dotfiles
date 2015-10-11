# Edit the command line using your usual editor.

# Original author: godlygeek(https://github.com/godlygeek)
# github.com/godlygeek/zsh-files/.zfunctions/edit-command-line

function my-edit-command-line(){
    local tmpfile=${TMPPREFIX:-/tmp/zsh}ecl$$
    print -R - "$PREBUFFER$BUFFER" >$tmpfile
    exec </dev/tty
    NO_LCD=true ${VISUAL:-${EDITOR:-vi}} $tmpfile
    print -z - "$(<$tmpfile)"
    command rm -f $tmpfile
    zle send-break # Force reload from the buffer stack
}

# Map my function as a widget named "edit-command-line"
zle -N edit-command-line my-edit-command-line

# Emacs style:
# Enable Ctrl-x-e to trigger edit-command-line widget
bindkey '^x^e' edit-command-line

# Vi style:
# bindkey -M vicmd v edit-command-line
