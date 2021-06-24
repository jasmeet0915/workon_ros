#! /bin/bash

function workon_ros {
	typeset ws_name=$1

	ros_install_path="/opt/ros/$ws_name/setup.bash"

	if [ -f "$ros_install_path" ]
	then
		source $ros_install_path
		echo "Sourced the setup for ROS $ws_name"
		
		# add distro name to prompt 
		PS1="(`basename \"$ROS_DISTRO\"`) ${PS1-}"
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
		PS1="(`basename \"$ws_name-$ROS_DISTRO\"`) ${PS1-}"
	fi
}
