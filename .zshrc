# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/ozaharia/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="lambda"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup
plugins=(git)

source $ZSH/oh-my-zsh.sh
source $ZSH/env.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

function i3cheatsheet {
  grep -E "^bindsym" ~/.config/i3/config | awk '{$1=""; print $0}' | sed 's/^ *//g' | grep -vE "^XF86" | column | pr -2 -w 160 -t | less
}
export KAFKA_HOME='/home/ozaharia/apps/confluent-3.3.0'
export SPARK_HOME='/home/ozaharia/apps/spark-2.3.1'

bindkey -v
alias work="cd ~/work"
alias p="cd ~/projects"
alias tmp="cd ~/tmp"
alias bin="cd ~/bin"
alias apps="cd ~/apps"
alias kafka="cd ~/apps/confluent-3.3.0/bin"
alias gatling="ssh root@10.200.50.18"
alias i3c="vim ~/.config/i3/config"
alias termc="vim ~/.config/termite/config"
alias aw="vim ~/.config/awesome/rc.lua"
alias reload="source ~/.zshrc"
alias rc="vim ~/.zshrc"
alias dow="cd ~/Downloads"
alias back='feh --bg-scale "/home/ozaharia/Pictures/$((RANDOM%60)).jpg"'
alias ll='ls -al'
alias cal='ncal -3Mb'
alias inline='cd /home/ozaharia/projects/inline/haskell && ls -al'
alias kc='cd /home/ozaharia/projects/scala/kclient && ls -al'
alias ovpn="oathtool --base32 --totp $OSECRET | xclip -sel clip && sudo openvpn  --config ~/.openvpn/client.ovpn"
alias s='sbt -mem 4000'
alias sd='sbt -mem 4000 -jvmDebug 9999'
alias v='nvim'

setxkbmap us -variant colemak
bindkey '^R' history-incremental-search-backward

alias start-kafka="($KAFKA_HOME/bin/zookeeper-server-start $KAFKA_HOME/etc/kafka/zookeeper.properties &  sleep 3 && $KAFKA_HOME/bin/kafka-server-start $KAFKA_HOME/etc/kafka/server.properties &)"
#xinput set-float-prop 'DLL07D1:01 044E:120B' 'Device Accel Constant Deceleration' 4  

if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte-2.91.sh
  __vte_osc7
fi
export GOROOT=/usr/local/go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin:/home/ozaharia/go/bin:/home/ozaharia/.cargo/bin:/home/ozaharia/.local/bin:/home/ozaharia/bin:/home/ozaharia/.cabal/bin:/home/ozaharia/node_modules/.bin:/home/ozaharia/apps/apache-maven-3.6.0/bin:/usr/bin:/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export XDG_RUNTIME_DIR=/run/user/`id -u`

source ~/.xsessionrc
#setxkbmap -option ctrl:nocaps
#pkill -f xcape
#xcape -e 'Control_L=Escape'
#xmodmap -e 'keycode 77 = NoSymbol Num_Lock'

export IDEA_JDK=~/bin/jdk-idea
source ~/work/env.sh
export TERM=xterm-color
synclient MaxTapTime=0
export LD_LIBRARY_PATH=/usr/local/lib

alias aws_whoami='aws iam list-account-aliases'

function common_wehkamp(){
  export AWS_DEFAULT_REGION=eu-west-1
  export BLAZE_COUNTRY=nl
  export BLAZE_LABEL=wehkamp
  aws_whoami
}

function playground(){
  export AWS_PROFILE=blaze_play_ground_dev
  export BLAZE_ENV=playground
  common_wehkamp
}

function dev(){
  export AWS_PROFILE=blaze_nl_wehkamp_dev
  export BLAZE_ENV=dev
  common_wehkamp
}

function prod(){
  export AWS_PROFILE=blaze_nl_wehkamp_prod
  export BLAZE_ENV=prod
  common_wehkamp
}

