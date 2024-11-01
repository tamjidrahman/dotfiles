# TODO: switch from powerlevel10k to starship

# ---- General Configuration ----
# Load into tmux
if [ -z "$TMUX" ]; then
  exec tmux new-session -A -s main
fi

# Set default editor
export EDITOR=nvim

# Add local bin to PATH
export PATH="/Users/tamjidrahman/.local/bin:$PATH"

# ---- Powerlevel10k ----
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ---- History Configuration ----
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# ---- Node Version Manager (NVM) ----
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ---- ZSH Vi Mode ----
# NOTE: this takes over keybindings, set this first before fzf
ZVM_INIT_MODE=sourcing # setting to allow this mode to behave like other plugins (sequential sourcing)
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# ---- FZF (Fuzzy Finder) Configuration ----
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# Use fd instead of find for FZF
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Custom functions for FZF path and directory completion
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Load FZF Git integration
source ~/fzf-git.sh/fzf-git.sh

# FZF preview settings
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of FZF options
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ---- Tool Configurations ----
# Bat (better cat)
export BAT_THEME=gruvbox-dark

# ---- Source Additional Files ----
source ~/.aliases
[ -f ~/.secrets ] && source ~/.secrets

# ---- Autocomplete and Syntax Highlighting ----
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- Custom Autocompletions ----
# Repo autocomplete
source ~/.local/bin/repo

# Session autocomplete
source ~/.local/bin/session-completion.sh


