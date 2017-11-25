# Print out Memory, cpu and load using https://github.com/thewtex/tmux-mem-cpu-load

run_segment() {
	type tmux-mem-cpu-load >/dev/null 2>&1
	if [ "$?" -ne 0 ]; then
		return
	fi

    cor1=""

	stats=$(tmux-mem-cpu-load)

    mem=$(echo $stats | sed 's/\([0-9]*\/[0-9]*MB\).*/\1/')

    cpu=$(echo $stats | sed 's/.* \([0-9\.]*%\).*/\1/')
    cpu_int=$(echo $stats | sed 's/.* \([0-9]*\)\.[0-9]*%.*/\1/')
    # cpu_bar number
    if [ $cpu_int -gt 0 ] && [ $cpu_int -lt 10 ]; then
        cpu_bar="[#[fg=colour46]▍         #[fg=colour82,bold]]"
    elif [ $cpu_int -gt 9 ] && [ $cpu_int -lt 20 ]; then
        cpu_bar="[#[fg=colour46]▍#[fg=colour118]▍        #[fg=colour82,bold]]"
    elif [ $cpu_int -gt 19 ] && [ $cpu_int -lt 30 ]; then
        cpu_bar="[#[fg=colour46]▍#[fg=colour118]▍#[fg=colour190]▍       #[fg=colour82,bold]]"
    elif [ $cpu_int -gt 29 ] && [ $cpu_int -lt 40 ]; then
        cpu_bar="[#[fg=colour46]▍#[fg=colour118]▍#[fg=colour190]▍#[fg=colour226]▍      #[fg=colour82,bold]]"
    elif [ $cpu_int -gt 39 ] && [ $cpu_int -lt 50 ]; then
        cpu_bar="[#[fg=colour46]▍#[fg=colour118]▍#[fg=colour190]▍#[fg=colour226]▍#[fg=colour11]▍     #[fg=colour82,bold]]"
    elif [ $cpu_int -gt 49 ] && [ $cpu_int -lt 60 ]; then
        cpu_bar="[#[fg=colour46]▍#[fg=colour118]▍#[fg=colour190]▍#[fg=colour226]▍#[fg=colour11]▍#[fg=colour3]▍    #[fg=colour82,bold]]"
    elif [ $cpu_int -gt 59 ] && [ $cpu_int -lt 70 ]; then
        cpu_bar="[#[fg=colour46]▍#[fg=colour118]▍#[fg=colour190]▍#[fg=colour226]▍#[fg=colour11]▍#[fg=colour3]▍#[fg=colour208]▍   #[fg=colour82,bold]]"
    elif [ $cpu_int -gt 69 ] && [ $cpu_int -lt 80 ]; then
        cpu_bar="[#[fg=colour46]▍#[fg=colour118]▍#[fg=colour190]▍#[fg=colour226]▍#[fg=colour11]▍#[fg=colour3]▍#[fg=colour208]▍#[fg=colour202]▍  #[fg=colour82,bold]]"
    elif [ $cpu_int -gt 79 ] && [ $cpu_int -lt 90 ]; then
        cpu_bar="[#[fg=colour46]▍#[fg=colour118]▍#[fg=colour190]▍#[fg=colour226]▍#[fg=colour11]▍#[fg=colour3]▍#[fg=colour208]▍#[fg=colour202]▍#[fg=colour196]▍ #[fg=colour82,bold]]"
    elif [ $cpu_int -gt 89 ] && [ $cpu_int -lt 100 ]; then
        cpu_bar="[#[fg=colour46]▍#[fg=colour118]▍#[fg=colour190]▍#[fg=colour226]▍#[fg=colour11]▍#[fg=colour3]▍#[fg=colour208]▍#[fg=colour202]▍#[fg=colour196]▍#[fg=colour1]▍#[fg=colour82,bold]]"
    else
        cpu_bar="[#[fg=red]██████████#[fg=colour82,bold]]"
    fi
    cpu_len=${#cpu}
    # make space consist
    if [ $cpu_len -eq 4 ]; then
        cpu=" $cpu"
    fi

    load=$(echo $stats | sed 's/.*% \([0-9\. ]*\)$/\1/')

	if [ -n "$stats" ]; then
		echo "#[fg=white]$load #[fg=white] #[fg=colour11]$mem #[fg=white] #[fg=colour82,bold]$cpu $cpu_bar"
	fi
	return 0
}
