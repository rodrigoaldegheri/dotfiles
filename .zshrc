# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# qualche comodità
alias inv='nvim $(fzf -m --preview="bat --color=always {}")'
alias pdf="termpdf.py"
alias sch="cd ~/desktop/scola"
alias pet="nvim ~/desktop/scola/italiano/si/petrarca/pet.tex"

alias zshrc="nvim ~/.zshrc"
alias neovim="nvim ~/.config/nvim"
alias v="nvim"
alias V="nvim ."


# per fzf
source <(fzf --zsh)

# git shit
alias gadd="git add ."
alias gcommit="git commit -s -m "
alias gpush="git push -u origin master"
alias gpull="git pull origin master --rebase"

# Backspace fix (macOS may need ^H instead of ^?)
bindkey '^?' backward-delete-char

publish() {
  if [ $# -eq 0 ]; then
    echo "No commit message provided!"
    echo "Usage: publish \"your commit message\""
    return 1
  fi

  git add .
  git commit -m "$*"
  git push -u origin "$(git rev-parse --abbrev-ref HEAD)"
}

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/Cellar/llvm/10.0.1/bin/clangd:$PATH"
export PATH="usr/local/opt/llvm/bin/clangd:$PATH"
export PATH="/Users/rodrigoaldegherizarateromero/go/bin:$PATH"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="/opt/homebrew/sbin:$PATH"

ZSH_THEME="robbyrussell"

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH
export PATH=/usr/local/bin/vim:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/rodrigoaldegherizarateromero/.oh-my-zsh"

# Set FZF Default to Ripgrep (must install ripgrep)
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --no-ignore-vcs"
# Set FZF DEFAULT OPTIONS
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search docker kubectl)

source $ZSH/oh-my-zsh.sh

source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#alias ls="colorls --group-directories-first"
#alias lss="/bin/ls"
# export KEYTIMEOUT=10

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
#source $(dirname $(gem which colorls))/tab_complete.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=3"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/Users/rodrigoaldegherizarateromero/.vscode-dotnet-sdk/.dotnet:$PATH"




# Enable completion system
autoload -Uz compinit

ZSH_DISABLE_COMPFIX=true

compinit

# enable menu selection (this creates menuselect keymap)
zstyle ':completion:*' menu select

# Enable vi mode
bindkey -v

# javier .dotfiles
# vi keys in tab menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'k' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
