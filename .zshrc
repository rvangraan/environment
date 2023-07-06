# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
eval "$(/opt/homebrew/bin/brew shellenv)"
# eval "$(/usr/libexec/path_helper)"




# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Fig post block. Keep at the bottom of this file.

source /opt/homebrew/opt/forgit/share/forgit/forgit.plugin.zsh

# source ~/src/configurations/oh-my-zsh.zsh

source ~/src/configurations/git-aliases.sh

source ~/src/configurations/fzf.zsh

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
