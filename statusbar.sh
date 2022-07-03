#Connor's DWM status bar script

#need the status2d patch for colors and formatting: https://dwm.suckless.org/patches/status2d/

background="#272833"
foreground="#c5c8c6"
black="#282a2e"
red="#a54242"
yellow="#de935f"
light_red="#cc6666"
light_black="#363b41"
green="#889C43"
light_green="#a0b765"
blue="#466279"
light_blue="#5f819d"
cyan="#62878d"
light_cyan="#87b7ba"

cpu() {
	cpu_avg=$(printf $[100-$(vmstat 1 2|tail -1|awk '{print $15}')])		#Fetch cpu load over a period of time (stolen from: https://askubuntu.com/questions/274349/getting-cpu-usage-realtime
	printf "^c$background^^b$light_red^ CPU "
	printf "^c$foreground^^b$light_black^ $cpu_avg%% "		#escape %
	
}

mem() {
	mem=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | sed "s/\..*//g")	#stolen from: https://stackoverflow.com/questions/10585978/how-to-get-the-percentage-of-memory-free-with-a-linux-command
	printf "^c$background^^b$yellow^ MEM "
	printf "^c$foreground^^b$light_black^ $mem%% "		#escape %
}

clock() {
	printf "^c$foreground^^b$light_blue^   "
	printf "^c$foreground^^b$blue^ $(date '+%H:%M, %b %d') "
}

battery() {
	PERCENT=$(cat /sys/class/power_supply/BAT0/capacity)
	STATUS=$(cat /sys/class/power_supply/BAT0/status)
	
	
	if [ "$STATUS" = "Charging" ]; then
		ICON="";
		COL="$light_green";
	else
		if [ $PERCENT -gt 90 ]; then
			ICON="";
			COL="$light_green";
		elif [ $PERCENT -gt 60 ] && [ $PERCENT -lt 91 ]; then
			ICON="";
			COL="$light_green";
		elif [ $PERCENT -gt 40 ] && [ $PERCENT -lt 61 ]; then
			ICON="";
			COL="$light_green";
		elif [ $PERCENT -gt 20 ] && [ $PERCENT -lt 41 ]; then
			ICON="";
			COL="$light_green";
		else
			ICON="";
			COL="$light_red";
		fi
	fi

	printf "^c$COL^^b$light_black^ $ICON $PERCENT "
}

pulseaudiovol() {
    VOL=$(pamixer --get-volume)
    STATE=$(pamixer --get-mute)

	printf "  ^c$light_cyan^^b$background^$VOL%%"
	
	printf "^c$light_cyan^^b$background^ "    
 
	if [ "$STATE" = "true" ] || [ "$VOL" -eq 0 ]; then
		printf "婢"
	elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
		printf ""
	elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
		printf "墳"
	else
		printf ""
	fi

	printf " "
}

end() {
	printf "^c$light_blue^^b$background^Connor Michalec  "
}


reset() {
	printf "^c$foreground^^b$background^"
}

updateTicks=200
tick=0

cpu_str=$(cpu) #initial reading

while true; do
	if [[ $(($tick % $updateTicks)) == 0 ]]; then 
		#this exists so cpu status will update slower than everytyhing else, that the 1 second delay the cpu reading requires doesn't have to happen every time everything else wants to update.
		cpu_str=$(cpu) #requires 1sec wait
		tick=0
	fi;	
	tick=$(($tick + 1))

	barstring=" $(pulseaudiovol)$(reset)  $(battery)$(reset)  $cpu_str$(reset)  $(mem)$(reset)  $(clock)$(reset)  $(end)$(reset) "
	xsetroot -name "$barstring"

	sleep 0.85 #delay higher for laptop build(less updates)

done;
