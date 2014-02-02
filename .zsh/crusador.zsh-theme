# Based of af-magic.zsh-theme by Andy Fleming
#
# Author: Jitesh
#
# Created on:		June 19, 2012
# Last modified on:	June 20, 2012


if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$FG[203]%}×%? %{$reset_color%})"

# primary prompt
PROMPT=$return_code'%{$fg_bold[blue]%}%~ $(git_prompt_info)$FG[105]%(!.#.» )%{$reset_color%}'
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

# color vars
eval my_gray='$FG[237]'
eval my_orange='$FG[166]'

# right prompt
RPROMPT='$my_gray%n@%m%{$reset_color%}'

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$my_orange"
ZSH_THEME_GIT_PROMPT_CLEAN=" "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%} »%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
