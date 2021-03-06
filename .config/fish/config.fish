#!/usr/bin/fish

function i3cheatsheet
  grep -E "^bindsym" ~/.config/i3/config | awk '{$1=""; print $0}' | sed 's/^ *//g' | grep -vE "^XF86" | column | pr -2 -w 160 -t | less
end

source $HOME/.oh-my-zsh/env.sh

set -x EDITOR nvim.appimage
set -x BROWSER vivaldi-stable
set -x KAFKA_HOME /home/ozaharia/apps/confluent-3.3.0
set -x SPARK_HOME /home/ozaharia/apps/spark-2.3.1
set -x TERM xterm-256color
set -x LD_LIBRARY_PATH /usr/local/lib
set -x PATH $PATH $GOPATH/bin $GOROOT/bin $HOME/go/bin $HOME/.cargo/bin $HOME/.local/bin $HOME/bin $HOME/.cabal/bin $HOME/node_modules/.bin $HOME/apps/apache-maven-3.6.0/bin $HOME/apps/gonvim $HOME/.npm-global/bin $HOME/apps/purescript $HOME/.local/share/coursier/bin /bin /usr/sbin /snap/bin /usr/local/bin $HOME/.istioctl/bin
set -x BAT_THEME ansi-light
set -x JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
set -x NVM_DIR $HOME/.nvm
set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -x BLAZE_SBT_CHECK_UPDATES_INTERVAL 0


alias work="cd ~/work"
alias p="cd ~/projects"
alias int="cd ~/projects/wantsome/interactive/interactive-backend"
alias testr="cd ~/projects/wantsome/interactive/interactive-testr-site"
alias tmp="cd ~/tmp"
alias bin="cd ~/bin"
alias apps="cd ~/apps"
alias kafka="cd ~/apps/confluent-3.3.0/bin"
alias kafka2="cd ~/apps/kafka_2.12-2.1.0/bin"
alias gatling="ssh root@10.200.50.18"
alias i3c="vim ~/.config/i3/config"
alias termc="vim ~/.config/termite/config"
alias reload="source ~/.config/fish/config.fish"
alias r="source ~/.config/fish/config.fish"
alias rc="vim ~/.config/fish/config.fish"
alias dow="cd ~/Downloads"
alias back='feh --bg-scale /home/ozaharia/Pictures/(random 1 60).jpg'
alias ll='ls -al'
alias cal='ncal -3Mb'
alias inline='cd /home/ozaharia/projects/inline/haskell and ls -al'
alias kc='cd /home/ozaharia/projects/scala/kclient and  ls -al'
alias ovpn="oathtool --base32 --totp $OSECRET | xclip -sel clip ;sudo openvpn --config ~/.openvpn/client.ovpn"
alias s='sbt -mem 2000'
alias sd='sbt -mem 2000 -jvmDebug 9999'
alias clip='xclip -sel clip'
alias v='nvim.appimage'
alias dc='docker-compose'
alias dp='docker ps'
alias gca='git add . && git commit --amend --no-edit'
alias gst='git status'
alias ga='git add .'
alias ds='docker stop (docker ps -aq)'
alias dr='docker rm (docker ps -aq)'
alias pm='cd /home/ozaharia/work/blaze-product-merge-service'
alias pl='cd /home/ozaharia/work/blaze-lib-merge'
alias nm='cd /home/ozaharia/work/blaze-nifi-cluster-manager-service'
alias ns='cd /home/ozaharia/work/blaze-nifi-cluster-manager-site'
alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
alias ro='cd (git rev-parse --show-toplevel)'
alias vi='nvim -u /home/ozaharia/.config/nvim/ini.vim'
alias vic='vi ~/.config/nvim/ini.vim'
alias vc='vi ~/.config/nvim/init.vim'
alias aws_whoami='aws iam list-account-aliases'

setxkbmap us -variant colemak

#xinput set-float-prop 'DLL07D1:01 044E:120B' 'Device Accel Constant Deceleration' 4  

source ~/.xsessionrc
#setxkbmap -option ctrl:nocaps
#pkill -f xcape
#xcape -e 'Control_L=Escape'
#xmodmap -e 'keycode 77 = NoSymbol Num_Lock'

source ~/work/env.sh
synclient MaxTapTime=0

fish_vi_key_bindings
set -g theme_display_git_ahead_verbose yes
numlockx off
bind o accept-autosuggestion
bind -M insert \co accept-autosuggestion

#set devices (xinput list)
#if string match -qr 'BluetoothMouse3600 Mouse' $devices
#	xinput set-button-map (xinput list --id-only "BluetoothMouse3600 Mouse")  3 2 1 
#end


# OPAM configuration
# source /home/ozaharia/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true
back
