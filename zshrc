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
 fi

 echo ${CMD} ${FTYPE} ${MACHINE} ${FILENAME}
}

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
if which mvim > /dev/null
then
  export EDITOR='mvim'
else
  export EDITOR='vim'
fi
if [[ "$TERM_PROGRAM" != "iTerm.app" ]] && [[ ! -z "$SSH_CLIENT" ]]
then
  export localeditor
  alias mvim=localeditor
else
  disable -f localeditor
fi

# Fuck configuration
eval $(thefuck --alias)

# Add additional user scripts
export PATH=$HOME/bin:$PATH

# AWS Useful Aliases
alias whoiam='aws sts get-caller-identity'

# Powerline
source $(python3 -m pip show powerline-status | egrep "^Location:" | cut -f2- -d\: | xargs)/powerline/bindings/zsh/powerline.zsh

# SCM Breeze
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"
