# Global Order: zshenv, zprofile, zshrc, zlogin

fpath=($HOME/.zsh/completion $fpath)

READNULLCMD=${PAGER:-/usr/bin/pager}

zstyle ':completion:*' completer _complete _ignored _correct
zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+r:|[._-:,]=** r:|=**'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:processes' command 'ps ax'
eval $(dircolors)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/sbin /sbin $PATH 

#zstyle ':completion:*' completer _expand _complete _correct _approximate
#zstyle ':completion:*' expand prefix suffix
#zstyle ':completion:*' group-name ''
#zstyle ':completion:*' insert-unambiguous true
#zstyle ':completion:*' list-suffixes true
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=** r:|=**' 'm:{a-z}={A-Z} r:|[._-]=** r:|=**' 'm:{a-z}={A-Z} r:|[._-]=** r:|=**' 'm:{a-z}={A-Z} r:|[._-]=** r:|=**'
#zstyle ':completion:*' max-errors 1
#zstyle ':completion:*' menu select=1
#zstyle ':completion:*' original true
#zstyle ':completion:*' preserve-prefix '//[^/]##/'
#zstyle ':completion:*' select-prompt %S%p%s
#zstyle ':completion:*' verbose true

autoload -U compinit
compinit

export WORDCHARS=${WORDCHARS//\//}
export WORDCHARS=${WORDCHARS//\./}

export RIPGREP_CONFIG_PATH=~/.ripgreprc

bindkey "^[Od" backward-word
bindkey "^[Oc" forward-word
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word
bindkey "\e[3~" delete-char
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history

export HISTFILE=~/.zsh_history
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE

setopt AUTO_CD
autoload colors zsh/terminfo
colors

#RPROMPT="%D %*"
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
#zstyle ':vcs_info:git:*' formats '%m %b'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' patch-format '%8>>%p%<< (%n applied)'
zstyle ':vcs_info:*' unstagedstr '(unst)'
zstyle ':vcs_info:*' stagedstr '(st)'
zstyle ':vcs_info:git*' actionformats "%m (%a)%{$fg[red]%}%u%{$reset_color%}%{$fg[green]%}%c%{$reset_color%}"
zstyle ':vcs_info:git*' formats "%m %b%{$fg[red]%}%u%{$reset_color%}%{$fg[green]%}%c%{$reset_color%}"
zstyle ':vcs_info:*' enable git
RPROMPT=\$vcs_info_msg_0_

#PROMPT="%F{2}%M%{$reset_color%}%b/%(?.%{$fg[blue]%}%n:%F{015}%~%#.%{$fg[red]%}%n:%F{015}%~%#)%F{007}%{$fg[default]%} "
PROMPT="%F{2}%M%{$reset_color%}%b%(?.%{$fg[blue]%}:%F{015}%~%#.%{$fg[red]%}:%F{015}%~%#)%F{007}%{$fg[default]%} "
autoload -U promptinit
promptinit

preexec () {print -Pn "\e]0;$1\a"}
precmd () { print -Pn "\e]0;%n@%M:%~\a" }

alias cp='cp -i'
alias rm='rm -i'
alias ls='ls -F --color'
alias ll='ls -lF'
alias la='ls -AF'
alias lS='ls -lahSrF'
alias grep='grep --color'

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export MANLESS="\$MAN_PN %pB\%"
export LESS="-M -R +p"

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# by vseleznv
__dot()
{
    if [[ $LBUFFER = *. ]]
    then
        LBUFFER+=./
    elif [[ $LBUFFER = cd ]] || [[ -f `/usr/bin/which --skip-alias $LBUFFER 2>/dev/null` ]]
    then
        LBUFFER+=\ .
    else
        LBUFFER+=.
    fi
}
autoload -U __dot
zle -N __dot
bindkey .           __dot

autoload -U copy-earlier-word
zle -N copy-earlier-word
bindkey '^[,' copy-earlier-word


#source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Highlighting. Must be included at the end!
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#bbbbbb'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=#bbbbbb'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#bbbbbb'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#bbbbbb'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#bbbbbb'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#bbbbbb'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#bbbbbb'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#bbbbbb'
ZSH_HIGHLIGHT_STYLES[default]='fg=#bbbbbb'
ZSH_HIGHLIGHT_STYLES[cursor]='fg=#bbbbbb'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#00d8eb'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#00d8eb'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#00d8eb'
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=''
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=''
ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=blue'
ZSH_HIGHLIGHT_STYLES[command-substitution]='none'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[process-substitution]='none'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='none'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='none'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[assign]='none'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[comment]='fg=black,bold'
ZSH_HIGHLIGHT_STYLES[named-fd]='none'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='none'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#00d8eb'
ZSH_HIGHLIGHT_MAXLENGTH=256
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
