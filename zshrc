#!/bin/zsh
# ~/.zshrc

# zsh completion
autoload -U compinit
compinit

typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BDésolé, pas de résultats pour : %d%b'
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' rehash true
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:mv:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes

# zsh options
setopt nobeep				        # Turn off the visual bell
setopt auto_cd				      # Change directory by typing a directory name on its own
setopt extended_glob			  # Turn on the more powerful pattern matching features
setopt append_history       # Prevent last shell from overwrite history of all shells
setopt hist_no_store			  # Prevent history command from being stored in HISTFILE
setopt hist_ignore_dups			# Prevent duplicates entries to be saved in HISTIFLE
setopt inc_append_history   # Save every command before it is executed
setopt share_history        # Retrieve history everytime it is called upon
setopt prompt_percent			  # Allow percent escapes to be replaced
setopt prompt_subst			    # Allow to include variables and substitutions in prompts
setopt no_prompt_cr			    # Disable auto carriage return at the end of the prompt 

# env 
export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE=~/.history
export EDITOR=vim
export TERM='rxvt-unicode-256color'
export PATH=$PATH:/home/xavier/.local/bin
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# bindkeys
bindkey -e 
bindkey "^Q" backward-word

# colors
autoload colors
colors

for COLOR in RED GREEN YELLOW WHITE BLACK CYAN; do
    eval $COLOR='%{$fg[${(L)COLOR}]%}'         
    eval BRIGHT${COLOR}='%{$fg_bold[${(L)COLOR}]%}'
done                                                 
DEFAULT="%{${reset_color}%}";                       

# ls colors 
if test -x =dircolors; then
    eval "`dircolors`"
    export LS_COLORS="*.ogm=01;35:*.pkg.tar=01;31:*.pkg.tar.xz=01;31:${LS_COLORS}"
    export ZLS_COLORS=$LS_COLORS
fi

# extensions
alias -s tex=vim
alias -s txt=vim
alias -s pdf=zathura
alias -s png=feh
alias -s jpg=feh
alias -s JPG=feh
alias -s xcf=gimp
alias -s mov=vlc
alias -s html=firefox
alias -s doc=libreoffice
alias -s docx=libreoffice
alias -s xls=libreoffice
alias -s xlsx=libreoffice
alias -s ppt=libreoffice
alias -s pptx=libreoffice
alias -s zip="unzip -vl"
alias -s xz="tar -Jtvf"
alias -s gz="tar -ztvf"
alias -s tar="tar -tvf"
alias -s pcap="wireshark"
alias -s pcapng="wireshark"

# commands
alias ls='ls -XBlhp --color --group-directories-first --time-style=+"%d-%m-%Y %H:%M"'
alias la='ls -AXlhp --color --group-directories-first --time-style=+"%d-%m-%Y %H:%M"'
alias lr='ls -RXBlhp --color --group-directories-first --time-style=+"%d-%m-%Y %H:%M"'
alias lra='ls -ARXlhp --color --group-directories-first --time-style=+"%d-%m-%Y %H:%M"'
alias lsd='ls -RXlhbpd --color --group-directories-first --time-style=+"%d-%m-%Y %H:%M"'
alias du='du -hc --time-style=+"%d-%m-%Y %H:%M"' 
alias mkdir='mkdir -pv'
alias mount='mount | column -t'
alias grep='grep --color=auto'
alias feh='feh -. --auto-rotate --draw-exif --auto-zoom'
alias ip6='ip -6'
alias free='free -ht'
alias bzip2='lbzip2'
alias myip='curl ifconfig.io/ip'

# functions
sshlog() {
 DATE=`date +"%d-%m-%Y-%H%M"`
 ssh $* | tee -a ${DATE}_${1}.txt
}

# prompt
PS1="${DEFAULT}%~
${RED}>${DEFAULT} " 
RPS1='!${DEFAULT}%!'

# others
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/chruby/chruby.sh
source /usr/share/chruby/auto.sh
