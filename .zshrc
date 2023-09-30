# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


zi_home="${HOME}/.zi"
source "${zi_home}/bin/zi.zsh"

zi ice depth=1; zi light romkatv/powerlevel10k
zi light zsh-users/zsh-autosuggestions
zi light zsh-users/zsh-completions
zi light zsh-users/zsh-history-substring-search
zi light z-shell/F-Sy-H

setopt auto_cd
setopt hist_ignore_dups

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
CASE_SENSITIVE='false'

autoload -U compinit; compinit

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


if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

PATH=$HOME/go/bin:$PATH

#eval "$(fnm env --use-on-cd)" # fnm initialization

eval "$(direnv hook zsh)" # direvn initialization


# thefuck alias
fuck () {
    TF_PYTHONIOENCODING=$PYTHONIOENCODING;
    export TF_SHELL=zsh;
    export TF_ALIAS=fuck;
    TF_SHELL_ALIASES=$(alias);
    export TF_SHELL_ALIASES;
    TF_HISTORY="$(fc -ln -10)";
    export TF_HISTORY;
    export PYTHONIOENCODING=utf-8;
    TF_CMD=$(
        thefuck THEFUCK_ARGUMENT_PLACEHOLDER $@
    ) && eval $TF_CMD;
    unset TF_HISTORY;
    export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
    test -n "$TF_CMD" && print -s $TF_CMD
}

# fnm
export PATH="/home/caio/.local/share/fnm:$PATH"
eval "`fnm env`"

#flutter
export PATH=/opt/flutter/bin:$PATH
export CHROME_EXECUTABLE=google-chrome-stable

# fnm
export PATH="/home/caio/.local/share/fnm:$PATH"
eval "`fnm env`"

# zsh
eval "$(navi widget zsh)"
