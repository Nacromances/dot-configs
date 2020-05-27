stty -ixon # Disable ctrl-s
source ~/.bash_profile
unset GREP_OPTIONS


function conda_env {
## >>> conda initialize >>>
## !! Contents within this block are managed by 'conda init' !!
__conda_setup="$($HOME/anaconda3/bin/conda 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/sami/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
## <<< conda initialize <<<
}


function disassmble {
    gdb $1 -ex 'set pagination off' -ex "disassemble /mr $2" -ex 'quit' | c++filt
}

