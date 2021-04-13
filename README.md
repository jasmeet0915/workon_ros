# Usage Instructions
* Export anenvironment variable named <code>ROS_WORKON_HOME</code> with the path containing all your workspaces or the installation of all your ROS distros using this command: <code>export ROS_WORKON_HOME="/opt/ros"</code>
* Source the <code>workon_ros_wrapper.sh</code> shell script with this command: <code> source /path/to/script/workon_ros_wrapper.sh</code>
* Add the above lines to the .bashrc scripts so they executed everytime a terminal is opened.
* Execute the following command to source the setup file of that ros_distro or workspace: <code>workon_ros distro_name</code>
