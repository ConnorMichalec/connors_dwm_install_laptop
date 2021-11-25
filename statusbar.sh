#Connor's DWM status bar script

#need the status2d patch for colors and formatting: https://dwm.suckless.org/patches/status2d/

background="#272833"
foreground="#c5c8c6"
black="#282a2e"
red="#a54242"
light_red="#cc6666"
light_black="#363b41"
green="#889C43"
light_green="#a0b765"

spacer_1char() {
	print "^b$background^ "
}

cpu() {
	cpu_avg=$(printf $[100-$(vmstat 1 2|tail -1|awk '{print $15}')])		#Fetch cpu load over a period of time (stolen from: https://askubuntu.com/questions/274349/getting-cpu-usage-realtime
	printf "^c$background^ ^b$light_red^ CPU"
	printf "^c$foreground^ ^b$light_black^ $cpu_avg%%"		#escape %%
	
}

end() {
	printf "^c$foreground^ ^b$background^ Connor Michalec"
}





update() {
	xsetroot -name "$(cpu)$(end)"
}

updateTicks=5;
tick=0;

while true; do
	if [[ $(($tick % $updateTicks)) == 0 ]]; then #only update if tick is a multiple of updateTicks
		$(update)
	fi;	

	tick=$(($tick + 1))

	sleep 1;
done;
