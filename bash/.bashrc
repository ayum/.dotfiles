# .bashrc

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ "$PS1" ]; then
   PS1="${PS1%\\\$*}\n\[\e[${PROMPT_COLOR}m\]⤷\[\e[0m\]\\$ "
fi

if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

