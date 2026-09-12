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
if [[ ":$PATH:" != *":$HOME/.opencode/bin:"* ]]; then
    PATH="$HOME/.opencode/bin:$PATH"
fi
export PATH
export LC_MESSAGES=en_US.UTF-8
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
