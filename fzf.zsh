fzf-history() {
  local SELECTED
  local NUM
  setopt localoptions noglobsubst noposixbuiltins pipefail 2>/dev/null
  SELECTED=($(
    fc -rl 1 |
      fzf \
        --prompt "[history]: " \
        --height "50%" \
        -n2..,.. \
        --tiebreak=index --bind=ctrl-r:toggle-sort \
        --query "$LBUFFER"
  ))
  if [ -n "$SELECTED" ]; then
    NUM=${SELECTED[1]}
    if [ -n "$NUM" ]; then
      zle vi-fetch-history -n $NUM
    fi
  fi
  zle reset-prompt
}
zle -N fzf-history

fzf-project-cd() {
  local DIR=$(
    fd -H "^.git\$" -d 4 "$HOME/src" | sed "s_${HOME}/src/__; s_/.git.*__;" |
      fzf \
        --prompt "[project]: " \
        -n2..,.. \
        --tiebreak=index --bind=ctrl-r:toggle-sort \
        --preview "bat --color=always --style=header,grid --line-range :100 $HOME/src/{}/README.md" \
        --query "$LBUFFER"
  )
  if [[ -n "$DIR" ]]; then
    BUFFER="cd $HOME/src/$DIR"
    zle accept-line
  fi
  zle redisplay
}
zle -N fzf-project-cd

bindkey '^r' fzf-history
bindkey '^g' fzf-project-cd

