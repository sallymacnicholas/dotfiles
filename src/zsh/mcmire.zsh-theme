# This is mostly based on:
# <http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/>
#
# For help on how prompts work, read:
# <http://www.acm.uiuc.edu/workshops/zsh/prompt/escapes.html>
#
# For help on how colors work, read:
#
# * <https://wiki.archlinux.org/index.php/zsh#Customizing_the_prompt>
# * <https://wiki.archlinux.org/index.php/zsh#Colors>

function Color {
  echo -n "%{$fg[$1]%}$2%{$reset_color%}"
}

function Color__red {
  echo "$(Color red "$1")"
}

function Color__green {
  echo "$(Color green "$1")"
}

function Color__yellow {
  echo "$(Color yellow "$1")"
}

function Color__blue {
  echo "$(Color blue "$1")"
}

function Color__magenta {
  echo "$(Color magenta "$1")"
}

function Color__cyan {
  echo "$(Color cyan "$1")"
}

function Color__gray {
  echo "$(Color black "$1")"
}

function Prompt__Fragment__collapsed_pwd {
  echo "${PWD/#$HOME/~}"
}

function Prompt__Fragment__username {
  echo -n '%n'
}

function Prompt__Fragment__host {
  echo -n '%m'
}

function Prompt__Fragment__git_branch {
  local ref=""

  ref="$(git symbolic-ref HEAD 2>/dev/null)"

  if [[ -z $ref ]]; then
    ref="$(git rev-parse --short HEAD 2>/dev/null)"
  fi

  # remove "refs/heads/" from beginning of $ref
  echo "${ref#refs/heads/}"
}

function Prompt__rvm_prompt_path {
  echo -n "$(which rvm-prompt &>/dev/null)"
}

function Prompt__username_fragment {
  echo -n "$(Color__blue "$(Prompt__Fragment__username)")"
}

function Prompt__git_branch_fragment {
  local git_branch="$(Prompt__Fragment__git_branch)"

  if [[ -n $git_branch ]]; then
    echo -n " on $(Color__yellow "$git_branch")"
  fi
}

function Prompt__cwd_fragment {
  echo -n " at $(Color__green "$(Prompt__Fragment__collapsed_pwd)")"
}

function Prompt__rc_char_fragment {
  echo -n "$(Prompt__Fragment__rc_char "$1") "
}

function Prompt__value {
  echo -n '$(Prompt__username_fragment)'
  echo -n '$(Prompt__cwd_fragment)'
  echo -n '$(Prompt__git_branch_fragment)'
  echo -n "\n"
  echo '∴ '
}

function Prompt__set {
  PROMPT="$(Prompt__value)"
}

autoload -Uz colors && colors

Prompt__set

# vi: ft=sh
