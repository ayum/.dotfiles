# .bash_profile

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    PATH="$HOME/bin:$PATH"
fi
if [[ ":$PATH:" != *":$HOME/go/bin:"* ]]; then
    PATH="$HOME/go/bin:$PATH"
fi
if [[ ":$PATH:" != *":$HOME/.opencode/bin:"* ]]; then
    PATH="$HOME/.opencode/bin:$PATH"
fi
LLVM="$(ls -d /usr/lib/llvm-* 2>/dev/null | sort -V | tail -n 1)"
if [[ ":$PATH:" != *":$LLVM/bin:"* ]]; then
    PATH="$LLVM/bin:$PATH"
fi
GO="$(ls -d /usr/lib/go-* 2>/dev/null | sort -V | tail -n 1)"
if [[ ":$PATH:" != *":$GO/bin:"* ]]; then
    GO="$GO/bin:$PATH"
fi
export PATH
export LC_MESSAGES=en_US.UTF-8
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
