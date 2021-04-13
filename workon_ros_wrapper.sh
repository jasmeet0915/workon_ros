#! /bin/bash

function workon_ros {
	typeset distro_name=$1
	setup="$WORKON_ROS_HOME/$distro_name/setup.bash"

	if [ ! -f "$setup" ]
	then
		echo "ERROR: Environment '$WORKON_ROS_HOME/$env_name' does not contain a setup script." >&2
		return 1
	fi
	
	source $setup
	echo "Sourced the setup for ROS $distro_name"
	
	PS1="(`basename \"$ROS_DISTRO\"`) ${PS1-}"
}
