# Copied from prezto - https://github.com/sorin-ionescu/prezto.git
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Expands .... to ../..
function expand-dot-to-parent-directory-path {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+='/..'
  else
    LBUFFER+='../'
  fi
}
zle -N expand-dot-to-parent-directory-path
bindkey -M "emacs" ".." expand-dot-to-parent-directory-path
