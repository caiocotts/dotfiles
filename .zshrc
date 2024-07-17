# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

################################################
################ Env variables #################
################################################

export RADV_PERFTEST='rt' # get steam games to use raytracing
export ELECTRON_OZONE_PLATFORM_HINT=wayland # attempt to make electron apps use wayland

HISTSIZE=1000 # number of commands to keep in history
SAVEHIST=1000 
HISTFILE=~/.zsh_history # history file location

CASE_SENSITIVE='false'

#################################################
############### Additions to PATH ###############
#################################################

export PATH=$HOME/go/bin:$PATH # add go binaries to path

#################################################
######### Initialize zi plugin manager ##########
#################################################

if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod go-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

zi_home="${HOME}/.zi"
source "${zi_home}/bin/zi.zsh"

################################################
############## Install plugins #################
################################################

zi ice depth=1; zi light romkatv/powerlevel10k
zi light z-shell/F-Sy-H
zi light zsh-users/zsh-autosuggestions
zi light zsh-users/zsh-completions
zi light zsh-users/zsh-history-substring-search
zi pack for ls_colors
zi pack for fzf

################################################
######## Zsh options and configuration #########
################################################

autoload -U compinit; compinit # enable completion

# autoload -Uz _zi
# (( ${+_comps} )) && _comps[zi]=_zi

setopt auto_cd
setopt hist_ignore_dups
setopt append_history
setopt inc_append_history
setopt share_history

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

################################################
################# Keybindings ##################
################################################

bindkey  "^[[A"   history-substring-search-up
bindkey  "^[[B"   history-substring-search-down
#bindkey "$terminfo[kcuu1]" history-substring-search-up
#bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

if [[ -n "$TMUX" ]]; then
  # Running in tmux
  bindkey "^[[1~" beginning-of-line
  bindkey "^[[4~" end-of-line
fi 
bindkey  "^[[3~"  delete-char

####################################################
############## Initialize other tools ##############
####################################################

eval "$(direnv hook zsh)" # direvn initialization

eval "$(zoxide init --cmd cd zsh)"  # initailize zoxide and substitute cd

eval "$(fnm env --use-on-cd)"

####################################################
########### p10k configuration selector ############
####################################################

if [[ -f ~/.p10k.zsh && $TERM != linux ]]; 
   then
       ln -sf /home/caio/dotfiles/.p10k.zsh ~/.p10k.zsh
       source ~/.p10k.zsh
   else
       ln -sf /home/caio/dotfiles/.p10k.zsh.console ~/.p10k.zsh
       source ~/.p10k.zsh
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
