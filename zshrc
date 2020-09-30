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
export EDITOR='vim'
alias vi=vim

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
