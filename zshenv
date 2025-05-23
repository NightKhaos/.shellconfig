pupdate() { case ":${PATH:=$1}:" in *:"$1":*) ;; *) export PATH="$1:$PATH" ;; esac; }

# Load ZSH other files
for file in $(find $HOME/.zsh -name "*.env"); do
  source "$file"
done

# Add additional user scripts
pupdate $HOME/bin

# Add history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history
setopt appendhistory

# Add Editor
export EDITOR=vim
