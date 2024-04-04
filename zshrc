# Setup autocompletion
mkdir -p ~/.zsh/completion
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# ZSH Settings
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# You may need to manually set your language environment
export LANG=en_AU.UTF-8

# Load ZSH other files
for file in $(find $HOME/.zsh -name "*.rc"); do
  source "$file"
done

# Shell preferences
alias ls="ls --color"

# direnv hooks
eval "$(direnv hook zsh)"

# AWS Useful Aliases and Functions
alias whoiam='aws sts get-caller-identity'
function awsall {
  export AWS_PAGER=""
  for i in `aws ec2 describe-regions --query "Regions[].{Name:RegionName}" --output text|sort -r`
  do
  echo "------"
  echo $i
  echo "------"
  echo -e "\n"
  if [ `echo "$@"|grep -i '\-\-region'|wc -l` -eq 1 ]
  then
      echo "You cannot use --region flag while using awsall"
      break
  fi
  aws $@ --region $i
  sleep 2
  done
  trap "break" INT TERM
}

# SCM Breeze
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"
export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"

# Setup thefuck
if which thefuck >/dev/null 2>/dev/null
then
  eval $(thefuck --alias)
fi

# Setup mise
if which mise >/dev/null 2>/dev/null
then
  if [[ -o interactive ]]; then
    eval "$(mise activate zsh)"
  else
    eval "$(mise activate zsh --shims)" 
  fi
fi

# Set the xterm title
case $TERM in
  xterm*)
    precmd () {print -Pn "\e]0;%n@%m: %~\a"}
    ;;
esac    


# Starship
if [[ $(uname -m) != "armv7l" ]]
then
  if which starship >/dev/null 2>/dev/null
  then
    eval "$(starship init zsh)"
    export STARSHIP_CONFIG=~/.shellconfig/starship.toml
  else
    echo 'WARNING: starship not installed, please install'
    autoload -U promptinit; promptinit
    prompt redhat
  fi
else
  autoload -U promptinit; promptinit
  if prompt -l | grep -wq pure
  then
    prompt pure
  else
    echo 'WARNING: pure not installed, please install'
    prompt redhat
  fi
fi
