export ZSH="/home/zain/.oh-my-zsh"

ZSH_THEME=""

plugins=(
  git
  zsh-autosuggestions
  fast-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

source /etc/profile.d/vte-2.91.sh

fpath+=('/usr/local/lib/node_modules/pure-prompt/functions')

autoload -U promptinit; promptinit
prompt pure

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
