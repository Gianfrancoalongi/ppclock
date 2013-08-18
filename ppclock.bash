#!/bin/bash

[[ $# != 1 ]] && echo "usage: $0 drive_time_in_minutes" && exit 1

main()
{
    while true
    do
	wait_until_next_swap $@
	send_change_message_to $(all_clients)
    done
}

all_clients()
{
    tmux list-clients | cut -d ':' -f 1
}

send_change_message_to()
{
    for((x=10;x>0;x--))
    do
	for CLIENT in $@
	do
	    tmux display-message -c ${CLIENT} "[switch driver in: ${x} seconds]"
	done
	sleep 1
    done
}

wait_until_next_swap()
{
    sleep $(($@ * 60 ))
}

main $@