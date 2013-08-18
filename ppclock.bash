#!/bin/bash

main()
{
    while true
    do
	wait_until_next_swap $@
	get_all_clients
	send_change_message_to_all_clients
    done
}

get_all_clients()
{
    CLIENTS=$(tmux list-clients | cut -d ':' -f 1)
}

send_change_message_to_all_clients()
{
    for((x=10;x>0;x--))
    do
	for CLIENT in ${CLIENTS}
	do
	    tmux display-message -c ${CLIENT} "[switch driver in: ${x} seconds]"
	done
	sleep 1
    done
}

wait_until_next_swap()
{
    sleep ${1}
}

main $@