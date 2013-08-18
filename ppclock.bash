#!/bin/bash

main()
{
    get_active_tmux_windows
    echo ${ACTIVE}
}

get_active_tmux_windows()
{
    ACTIVE=""
    for SESSION in $(tmux list-sessions | cut -d ':' -f 1)
    do
	ACTIVE+=" ${SESSION}:"$(tmux list-windows -t ${SESSION} | grep \(active\) | cut -d ':' -f 1)
    done
}

main