if filereadable(expand("~/.vimrc.basic"))
    so ~/.vimrc.basic
endif

if filereadable(expand("~/.vimrc.plugins"))
    so ~/.vimrc.plugins
endif
