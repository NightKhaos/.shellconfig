# Functions
localeditor() {
 CMD=ITERM-TRIGGER-open-with-local-editor
 MACHINE=${2-$(uname -n)}
 FILENAME=${1-.}
 if [[ -d ${FILENAME} ]]; then
   FILENAME=$(cd $FILENAME; pwd)
   FTYPE=directory
 elif [[ -f ${FILENAME} ]]; then
   DIRNAME=$(cd $(dirname $FILENAME); pwd)
   FILENAME=${DIRNAME}/$(basename ${FILENAME})
   FTYPE=file
 else
   1>&2 echo "Not a valid file or directory: ${FILENAME}"
   1>&2 echo "Touch file before use"
   return
 fi

 echo ${CMD} ${FTYPE} ${USERNAME} ${MACHINE} ${FILENAME}
}

pupdate() { case ":${PATH:=$1}:" in *:"$1":*) ;; *) export PATH="$1:$PATH" ;; esac; }

# ZSH Settings
autoload -Uz compinit
compinit 
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Load ZSH other files
for file in $(find $HOME/.zsh -name "*.rc"); do
  source "$file"
done

# You may need to manually set your language environment
export LANG=en_AU.UTF-8

# Preferred editor for local and remote sessions
if which mvim >/dev/null 2>/dev/null
then
  export EDITOR='mvim'
else
  export EDITOR='vim'
fi
if [[ "$TERM_PROGRAM" == "iTerm.app" ]] && ! [[ -e "$HOME/.zsh/99-iterm.rc" ]]
then
  curl -L https://iterm2.com/shell_integration/zsh -o ~/.zsh/99-iterm.rc
  source ~/.zsh/99-iterm.rc
elif [[ "$TERM_PROGRAM" != "iTerm.app" ]] && [[ ! -z "$SSH_CLIENT" ]]
then
  export localeditor
  alias mvim=localeditor
elif [[ "$TERM_PROGRAM" == 'Apple_Terminal' ]]
then
  # This will cause an implicit -w flag to the ssh-login script for Work Laptop (not in this repo)
  export WAIT_FOR_INPUT=true
else
  disable -f localeditor
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

# Powerline
source $(python3 -m pip show powerline-status | egrep "^Location:" | cut -f2- -d\: | xargs)/powerline/bindings/zsh/powerline.zsh

# SCM Breeze
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"
export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"

# Setup thefuck
if which thefuck >/dev/null
then
  eval $(thefuck --alias)
fi

# Setup autocompletion
mkdir -p ~/.zsh/completion
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i
