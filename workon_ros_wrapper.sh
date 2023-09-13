# Copyright (C) 2021 Jasmeet Singh - All Rights Reserved
# You may use, distribute and modify this code as per your requirement

function get_workon_ros_options {
	local workon_ros_options=$(ls $WORKON_ROS_HOME && ls /opt/ros)	
	echo "$workon_ros_options"
}	

function _workon_ros_completion {
	local curr_word suggestions 

	# COMP_WORDS is an array of words currently in command line
	# COMP_CWORD is index of current word in COMP_WORDS
	curr_word="${COMP_WORDS[COMP_CWORD]}"

	suggestions=$(get_workon_ros_options)
	COMPREPLY=( $(compgen -W "${suggestions}" -- ${curr_word}) )

	# register this completion function for workon_ros command
	complete -F _workon_ros_completion workon_ros
}

function Help {
	# Display Help
	echo "Use workon_ros to easily switch between ROS workspaces to speed up your workflow."
	echo "Set the WORKON_ROS_HOME environment variable to the path where all your workspaces reside."
	echo
	echo "Syntax: workon_ros[-c|h] workspace_name"
	echo "options:"
	echo "c     Also change the directory to workspace in the current shell."
	echo "h     Print this Help."
	echo
}

function workon_ros {
	# declare OPTIND locally so it resets everytime this function is called
	local OPTIND
	local change_directory=false
	local ws_name=$1

	# handle command line options
	while getopts c:h option
	do	
		case "${option}" 
		in
			h) # display Help
				Help
				return 1;;
			c) # set change directory to true
				change_directory=true
				ws_name=$OPTARG
				;;
		esac
	done

	local ws_path="/opt/ros/$ws_name/setup.bash"

	if [ ! -f "$ws_path" ]
	then
		ws_path="$WORKON_ROS_HOME/$ws_name/install/setup.bash"

		if [ ! -f "$ws_path" ]
		then
			ws_path="$WORKON_ROS_HOME/$ws_name/devel/setup.bash"

			if [ ! -f "$ws_path" ]
			then
				echo "$ws_name: No such workspace exists"
				return 1
			fi
		fi
	fi

	# check if the current shell is zsh & change the setup extension accordingly
	if [ -n "$ZSH_VERSION" ]
	then
		ws_path=$(sed 's/.bash/.zsh/g' <<< $ws_path)
	fi

	source $ws_path
	echo "Sourced the setup for $ws_name"

	if [ -n "$ZSH_VERSION" ]
	then
		# argcomplete for ros2 & colcon
		eval "$(register-python-argcomplete3 ros2)"
		eval "$(register-python-argcomplete3 colcon)"
	fi
	
	local NEWLINE=$'\n'

	if [ "$ws_name" = "$ROS_DISTRO" ]
	then
		PS1="($ROS_DISTRO) ${PS1}"
	else
		PS1="($ws_name)${NEWLINE}($ROS_DISTRO) ${PS1}"
	fi

	if [ $change_directory = true ]; then
		echo "Changing current directory to workspace: ${ws_path} since -c used"
		# remove everything after the ws_name from the path & append the ws_name again
		cd ${ws_path%$ws_name*}$ws_name 
	fi
}

# invoke tab completion function
_workon_ros_completion