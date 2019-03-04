#!/usr/bin/fish

function i3cheatsheet
  grep -E "^bindsym" ~/.config/i3/config | awk '{$1=""; print $0}' | sed 's/^ *//g' | grep -vE "^XF86" | column | pr -2 -w 160 -t | less
end

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
alias reload="source ~/.config/fish/config.fish"
alias rc="vim ~/.config/fish/config.fish"
alias dow="cd ~/Downloads"
alias back='feh --bg-scale "/home/ozaharia/Pictures/$((RANDOM%60)).jpg"'
alias ll='ls -al'
alias cal='ncal -3Mb'
alias inline='cd /home/ozaharia/projects/inline/haskell && ls -al'
alias kc='cd /home/ozaharia/projects/scala/kclient && ls -al'
alias ovpn="oathtool --base32 --totp $OSECRET | xclip -sel clip && sudo openvpn  --config ~/.openvpn/client.ovpn"
alias s='sbt -mem 4000'
alias sd='sbt -mem 4000 -jvmDebug 9999'

setxkbmap us -variant colemak
bindkey '^R' history-incremental-search-backward

alias start-kafka="($KAFKA_HOME/bin/zookeeper-server-start $KAFKA_HOME/etc/kafka/zookeeper.properties &  sleep 3 && $KAFKA_HOME/bin/kafka-server-start $KAFKA_HOME/etc/kafka/server.properties &)"
#xinput set-float-prop 'DLL07D1:01 044E:120B' 'Device Accel Constant Deceleration' 4  

export GOROOT=/usr/local/go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin:/home/ozaharia/go/bin:/home/ozaharia/.cargo/bin:/home/ozaharia/.local/bin:/home/ozaharia/bin:/home/ozaharia/.cabal/bin:/home/ozaharia/node_modules/.bin:/home/ozaharia/apps/apache-maven-3.6.0/bin

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
fish_vi_key_bindings
set -g theme_display_git_ahead_verbose yes
