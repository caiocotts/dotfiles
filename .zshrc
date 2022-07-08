# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /etc/zsh_command_not_found

zi_home="${HOME}/.zi"
source "${zi_home}/bin/zi.zsh"

zi ice depth=1; zi light romkatv/powerlevel10k
zi light zsh-users/zsh-autosuggestions
zi light zsh-users/zsh-completions
zi light zsh-users/zsh-history-substring-search
zi light zdharma/fast-syntax-highlighting

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history



bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval $(thefuck --alias)
PATH=$PATH:/home/caio/.local/bin
PATH=$PATH:/home/caio/.pub-cache/bin
