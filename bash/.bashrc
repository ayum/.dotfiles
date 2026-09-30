# .bashrc

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
fi

if [ "$PS1" ]; then
    PS1="\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\[\033[01;32m\]⤷\[\033[00m\]\$ "
fi

if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
