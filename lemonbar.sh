#!/bin/bash

CLOCK() {
	date '+%H:%M %d:%m:%Y'
}

WIFI() {
	ifconfig wlp3s0 | head -2 | tail -1 | awk '{print $2}' 
}

DISK() {
	df -h  /dev/mapper/cryptAntergos | tail -1 | awk '{print $4}'
}

DISK2() {
	df -h /dev/sdb1 | head -2 | tail -1 | awk '{print $4}'
}

WORKSPACES() {
	cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
    	tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`

    	for w in `seq 0 $((cur - 1))`; do line="${line}="; done
   	line="${line}|"
    	for w in `seq $((cur + 2)) $tot`; do line="${line}="; done
    	if [ "$line" == "=|" ] 
		then
			echo "1"

	elif [ "$line" == "|=" ]
		then
			echo "2"

	elif [ "$line" == "==|" ]
		then
			echo "3"

	elif [ "$line" == " =|=" ]
		then
			echo "4"

	fi 
}

while true; do
	echo " $(WORKSPACES)%{r}SSD: $(DISK)  HDD: $(DISK2)  IP: $(WIFI)  $(CLOCK)  "
	sleep 1
done
	
