# Set up the prompt

autoload -Uz promptinit
promptinit
prompt redhat

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# ctrl-u should only erase from current position
bindkey \^U backward-kill-line

HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history
setopt hist_ignore_space

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
#eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# use better word boundary recognition
#autoload -U select-word-style
#select-word-style bash

# list all files when we hit tab
compdef _path_files cd

if [[ -f ~/.bash_aliases ]]; then
    . ~/.bash_aliases
fi

alias ag='ag -s '
alias vi='nvim'
alias vim='vim'

GRADLE_SYSTEM="/usr/local/gradle/bin"
GRADLE_LOCAL="~/gradle-2.2.1/bin"

if [ -d $GRADLE_LOCAL ]; then
  export PATH=$PATH:$GRADLE_LOCAL
fi
if [ -d $GRADLE_SYSTEM ]; then
  export PATH=$PATH:$GRADLE_SYSTEM
fi

MAC_JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home"
LINUX_JAVA_HOME="/usr/lib/jvm/java-8-oracle"

if [ -d $MAC_JAVA_HOME ]; then
    export JAVA_HOME=$MAC_JAVA_HOME
elif [ -d $LINUX_JAVA_HOME ]; then
    export JAVA_HOME=$LINUX_JAVA_HOME
fi

source ~/.fzf.zsh
