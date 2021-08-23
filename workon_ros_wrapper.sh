#! /bin/bash

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
	echo "g     Also change the directory to workspace in the current shell."
	echo "h     Print this Help."
	echo
}

function workon_ros {
	typeset ws_name=$1

	ros_install_path="/opt/ros/$ws_name/setup.bash"

	if [ -f "$ros_install_path" ]
	then
		source $ros_install_path
		echo "Sourced the setup for ROS $ws_name"
		
		# add distro name to prompt 
		PS1="($ROS_DISTRO) ${PS1}"
	else
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

		source $ws_path
		echo "Sourced the setup for Workspace $ws_name"

		# add workspace + distro name to prompt
		PS1="($ws_name)\n($ROS_DISTRO) ${PS1}"
	fi
}

# invoke tab completion function
_workon_ros_completion
