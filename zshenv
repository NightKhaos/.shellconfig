pupdate() { case ":${PATH:=$1}:" in *:"$1":*) ;; *) export PATH="$1:$PATH" ;; esac; }

# Load ZSH other files
for file in $(find $HOME/.zsh -name "*.env"); do
  source "$file"
done

# Add additional user scripts
pupdate $HOME/bin

# Preferred editor for local and remote sessions
if which mvim >/dev/null 2>/dev/null
then
  export EDITOR='mvim'
else
  export EDITOR='vim'
fi