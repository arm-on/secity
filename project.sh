while true; do
    choice=$(zenity --width 500 --height 400 --list --text "Choose from the options:" --title "Menu" --ok-label="Show!" --cancel-label="Quit" --column=Options "About the developer" "Active users of the system" "System Groups" "Logged users" "Status of Grsecurity" "Status of Apparmor" "Status of SELinux" "Active Services of the system" "The Last Update of the system" "The list of all installed softwares")
    if [ "$?" != 0 ]
    then
        exit
    elif [ "$choice" = "About the developer" ]
        then
            zenity --width 800 --info --title "About Me" --text "My name is Arman Malekzadeh. Currently I'm a Computer Science student at Tehran Polytechnic.\n\nI hope you enjoy using this extra-small app!\n\nIf you have any good ideas on improving this software, Please feel free to send me an email.\nmalekzadeh@ieee.org"
            if [ "$?" != 0 ]
			then
				exit
			fi
    elif [ "$choice" = "Active users of the system" ]
        then    
            zenity --list --text "Users are listed below." --title "Result" --ok-label="Back to Menu" --cancel-label="Quit" --column=Users $(cut -d : -f 1 /etc/passwd)
            if [ "$?" != 0 ]
			then
				exit
			fi
    elif [ "$choice" = "System Groups" ]
		then
			zenity --list --text "Groups are listed below." --title "Result" --ok-label="Back to Menu" --cancel-label="Quit" --column=Groups $(id -Gn)
			if [ "$?" != 0 ]
			then
				exit
			fi
    elif [ "$choice" = "Logged users" ]
		then
			zenity --list --text "Logged users are listed below." --title "Result" --ok-label="Back to Menu" --cancel-label="Quit" --column="Logged Users" $(who | cut -d " " -f1)
			if [ "$?" != 0 ]
			then
				exit
			fi 
    elif [ "$choice" = "Status of Grsecurity" ]
		then
			grsec=$(gradm -S)
            grsec_ins_check=$(apt list gradm)
            if [[ $grsec_ins_check = *"installed"* ]]; then
                choice=$(zenity --info --title="Result" --text="GrSecurity Status: \n$grsec" --ok-label="Back to Menu" --extra-button "Quit")
            else
                choice=$(zenity  --width 600 --info --title="Result" --text="GrSecurity is not installed!" --ok-label="Back to Menu" --extra-button "Quit")
            fi
			if [ "$choice" = "Quit" ]
			then
				exit
			fi
    elif [ "$choice" = "Status of Apparmor" ]
		then
			apparmorstatus=$(systemctl status apparmor)
			choice=$(zenity --width 800 --info --title="Result" --text="Apparmor Status: \n$apparmorstatus" --ok-label="Back to Menu" --extra-button "Quit")
			if [ "$choice" = "Quit" ]
			then
				exit
			fi
    elif [ "$choice" = "Status of SELinux" ]
		then
			sestatus=$(sestatus)
            default_dir="/etc/sysconfig/selinux"
            if [ -d $default_dir ]
                then
                    choice=$(zenity --info --title="Result" --text="SELinux Status: \n$sestatus" --ok-label="Back to Menu" --extra-button "Quit")
                else
                    choice=$(zenity  --width 600 --info --title="Result" --text="SELinux is not installed!" --ok-label="Back to Menu" --extra-button "Quit")
            fi
			if [ "$choice" = "Quit" ]
			then
				exit
			fi
    elif [ "$choice" = "Active Services of the system" ]
		then
			zenity --list --text "The services listed below are active." --title "Result" --ok-label="Back to Menu" --cancel-label="Quit" --column="Service Name" $(service --status-all | awk '{print $4}')
            if [ "$?" != 0 ]
			then
				exit    
			fi
    elif [ "$choice" = "The Last Update of the system" ]
		then
			lastupdate=$(stat -c %y /var/lib/apt/periodic/update-success-stamp)
			choice=$(zenity --info --title="Result" --text="Last Update: \n$lastupdate" --ok-label="Back to Menu" --extra-button "Quit")
			if [ "$choice" = "Quit" ]
			then
				exit
			fi
    elif [ "$choice" = "The list of all installed softwares" ]
		then
			zenity --list --text "Installed packages are listed below." --title "Result" --ok-label="Back to Menu" --cancel-label="Quit" --column="Packages" $(dpkg --get-selections | grep -v deinstall | awk '{print $1}')
			if [ "$?" != 0 ]
			then
				exit    
			fi
    fi
done
