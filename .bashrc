# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Bash settings

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Env variables

export LC_ALL=en_US.UTF-8
export EDITOR=vim
export PATH="$HOME/go/bin:$HOME/.cargo/bin:$HOME/bin:$PATH"
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
  alias open=xdg-open

  . /etc/bash_completion.d/git-prompt

  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  fi

  . "$NVM_DIR/nvm.sh"
  . "$NVM_DIR/bash_completion"
fi

# Completions
if [ -f /usr/local/bin/terraform ]; then
  complete -C /usr/local/bin/terraform terraform
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
alias kns=kubens
alias ll='ls -lah --color=auto'

# Functions
function yr() {
  local script=$(jq -r ".scripts | keys[]" package.json | fzf)
  if [ -n "$script" ]; then
    local cmd=(yarn run "$script")
    # TODO: extract echo + history + exec into func (custom:exec)
    echo "${cmd[@]}"
    history -s "${cmd[@]}"
    "${cmd[@]}"
  fi
}

function gc() {
  local arg=$1
  if [ "$arg" == "-" ]; then
    git checkout -
    return
  fi

  local branch=$(git for-each-ref --format='%(refname:short)' refs/heads | fzf)
  if [ -n "$branch" ]; then
    local cmd=(git checkout "$branch")
    echo "${cmd[@]}"
    history -s "${cmd[@]}"
    "${cmd[@]}"
  fi

  local repo_root=$(git rev-parse --show-toplevel)
  if [ -f "${repo_root}/go.mod" ]; then
    go mod download
    go mod tidy
  fi

  if [ -f "${repo_root}/.nvmrc" ]; then
    nvm use
  fi

  if [ -f "${repo_root}/package.json" ]; then
    yarn
  fi
}

function j() {
  local job=$(jobs | fzf | ggrep -Po '\d+')
  if [ -n "$job" ]; then
    fg %$job
  fi
}

function kgrep() {
  local resource=$1
  local name=$2
  kubectl get "$resource" | grep -E "NAME|$name"
}

function kexec() {
  local cmd=$1
  if [ -z "$cmd" ]; then
    cmd=bash
  fi

  local pod=$(kubectl get pod | grep -v NAME | fzf | cut -d " " -f 1)
  if [ -n "$pod" ]; then
    local kube_cmd=(kubectl exec -it "$pod" "$cmd")
    echo "${kube_cmd[@]}"
    history -s "${kube_cmd[@]}"
    "${kube_cmd[@]}"
  fi
}

function kdesc() {
  local resource=$(kubectl api-resources | cut -d ' ' -f 1 | fzf)
  if [ -z "$resource" ]; then
    echo "Nothing selected"
    return
  fi

  local name=$(kubectl get "$resource" | cut -d ' ' -f 1 | fzf)
  if [ -z "$name" ]; then
    echo "Nothing selected"
    return
  fi

  local cmd=(kubectl describe "$resource" "$name")
  echo "${cmd[@]}"
  history -s "${cmd[@]}"
  "${cmd[@]}"
}

function klogs() {
  local pod=$(kubectl get pod | grep -v NAME | fzf | cut -d " " -f 1)
  if [ -n "$pod" ]; then
    local kube_cmd=(kubectl logs -f --tail=20 "$pod")
    echo "${kube_cmd[@]}"
    history -s "${kube_cmd[@]}"
    "${kube_cmd[@]}"
  fi
}

function testw() {
  local file=$(find . -type f -name '*_test.go' | fzf)
  if [ -n "$file" ]; then
    local cmd=(gow -c test "$file")
    echo "${cmd[@]}"
    history -s "${cmd[@]}"
    "${cmd[@]}"
  fi
}
