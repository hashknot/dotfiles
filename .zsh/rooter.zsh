# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Copied from https://github.com/vickychijwani/rooter.sh
#
#  Original author: Vicky Chijwani
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#
# cd to the project root (identified by the presence of a SCM directory, like
# .git, or .bzr)
#
# INSTALL:
#   * put something like this in your .zshrc:
#     . /path/to/rooter.zsh
#
#   This installs the 'cdr' command for use.
#
# USE:
#   $ pwd
#   /home/yeban/drizzle/drizzle/libdrizzle-2.0/libdrizzle
#   $ cdr
#   $ pwd
#   /home/yeban/src/drizzle/drizzle

# array of some known SCM directories
scmdirs=('.git' '.bzr')

# return true if the given directory has an SCM subdirectory
_has_scm_dir(){
    if [[ -d $1 ]]; then
        for scmdir in $scmdirs; do
            if [[ -d "$1/$scmdir" ]]; then
                return 0
            fi
        done
    fi

    return 1
}

# return the project root of the given directory
_get_root_dir(){
    local dir=$1

    if [[ -d $dir ]]; then
        while [ $dir != "/" ]
        do
            if _has_scm_dir $dir; then
                print $dir; return 0
            fi
            dir=$(dirname $dir)
        done
    fi

    return 1
}

# cd to the project root
cdr(){
    # use the first argument or the current working directory
    local dir
    [[ -n "$1" ]] && dir="$1" || dir="$(pwd)"

    [[ "$dir" = ".." ]] && dir="$(dirname `pwd`)"
    [[ "$dir" = "."  ]] && dir="$(pwd)"

    if [[ -d $dir ]]; then
        local root_dir=$(_get_root_dir $dir)
    fi

    cd $root_dir
}
