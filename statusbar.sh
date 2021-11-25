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

1cspacer() {	#1-char spacer
	printf "^b$background^ "
}

2cspacer() {	#2-char spacer
	printf "^b$background^  "
}

3cspacer() {	#3-char spacer
	printf "^b$background^   "
}

4cspacer() {	#4-char spacer
	printf "^b$background^    "
}

5cspacer() {	#5-char spacer
	printf "^b$background^     "
}

6cspacer() {	#6-char spacer
	printf "^b$background^      "
}

cpu() {
	cpu_avg=$(printf $[100-$(vmstat 1 2|tail -1|awk '{print $15}')])		#Fetch cpu load over a period of time (stolen from: https://askubuntu.com/questions/274349/getting-cpu-usage-realtime
	printf "^c$background^^b$light_red^ CPU "
	printf "^c$foreground^^b$light_black^ $cpu_avg%% "		#escape %
	
}

mem() {
	mem=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | sed "s/\..*//g")		#stolen from: https://stackoverflow.com/questions/10585978/how-to-get-the-percentage-of-memory-free-with-a-linux-command
	printf "^c$background^^b$yellow^ MEM "
	printf "^c$foreground^^b$light_black^ $mem%% "		#escape %
}

clock() {
	printf "^c$background^^b$light_blue^   "
	printf "^c$foreground^^b$blue^ $(date '+%H:%M, %b %d') "
}

end() {
	printf "^c$light_blue^^b$background^Connor Michalec  "
}





update() {
	xsetroot -name "$(2cspacer)$(cpu)$(2cspacer)$(mem)$(2cspacer)$(clock)$(2cspacer)$(end)$(1cspacer)"
}

updateTicks=1;
tick=0;

while true; do
	if [[ $(($tick % $updateTicks)) == 0 ]]; then #only update if tick is a multiple of updateTicks
		$(update)
	fi;	

	tick=$(($tick + 1))

	sleep 1;
done;
