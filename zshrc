pupdate() { case ":${PATH:=$1}:" in *:"$1":*) ;; *) export PATH="$1:$PATH" ;; esac; }

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


# Preferred editor for local and remote sessions
if which mvim >/dev/null 2>/dev/null
then
  export EDITOR='mvim'
else
  export EDITOR='vim'
fi
if [[ "$TERM_PROGRAM" == 'Apple_Terminal' ]]
then
  # This will cause an implicit -w flag to the ssh-login script for Work Laptop (not in this repo)
  export WAIT_FOR_INPUT=true
fi

# Shell preferences
alias ls="ls --color"

# Add additional user scripts
pupdate $HOME/bin

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
if which thefuck >/dev/null
then
  eval $(thefuck --alias)
fi

# Starship
if [[ $(uname -m) != "armv7l" ]]
then
  eval "$(starship init zsh)"
  export STARSHIP_CONFIG=~/.shellconfig/starship.toml
else
  fpath+=($HOME/.zsh/pure)
  autoload -U promptinit; promptinit
  prompt pure
fi
