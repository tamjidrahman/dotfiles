#!/usr/bin/env bash

_session_complete() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # If it's the first argument, complete with tmux session names
    if [[ ${COMP_CWORD} -eq 1 ]]; then
        opts=$(tmux list-sessions -F "#S" 2>/dev/null)
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi
}

complete -F _session_complete session
