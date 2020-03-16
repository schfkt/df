# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Env variables
export LC_ALL=en_US.UTF-8
export EDITOR=vim
export PATH="$HOME/.cargo/bin:$HOME/bin:$PATH"
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on"
export NVM_DIR="$HOME/.nvm"

# OS specific stuff
if [[ $OSTYPE =~ ^darwin ]]; then
  export BASH_SILENCE_DEPRECATION_WARNING=1

  . /usr/local/etc/bash_completion
  . /usr/local/etc/bash_completion.d/git-completion.bash
  . /usr/local/etc/bash_completion.d/git-prompt.sh

  . /usr/local/opt/nvm/nvm.sh
  . /usr/local/opt/nvm/etc/bash_completion.d/nvm
elif [[ $OSTYPE =~ ^linux ]]; then
  export SSH_ASKPASS=/usr/bin/ksshaskpass

  alias open=xdg-open
  alias vim=vimx

  . /usr/share/git-core/contrib/completion/git-prompt.sh

  . "$NVM_DIR/nvm.sh"
  . "$NVM_DIR/bash_completion"
fi

# Prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"
export PS1='
[\j] \w$(__git_ps1 " (%s)")
$ '

# Aliases
alias kc=kubectl
alias kx=kubectx
alias ll='ls -lah'

# Functions
function yr() {
  local script=$(jq -r ".scripts | keys[]" package.json | fzf)
  if [ -n "$script" ]; then
    echo "yarn run $script"
    yarn run "$script"
  fi
}

function gc() {
  local branch=$(git for-each-ref --format='%(refname:short)' refs/heads | fzf)
  if [ -n "$branch" ]; then
    git checkout "$branch"
  fi
}

function j() {
  local job=$(jobs | fzf | grep -Po '\d+')
  if [ -n "$job" ]; then
    fg %$job
  fi
}
