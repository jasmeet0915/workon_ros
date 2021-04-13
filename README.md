This was inspired by [virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/) which makes activating and managing virtual environments very easy. 
This script allows you to source setup.bash files for different ros distros in a similar way and also displays the name of the current activated distro in the command prompt in parenthesis. (shown below)

<img src="https://user-images.githubusercontent.com/23265149/114545620-cbda7680-9c79-11eb-984d-009e5b083a63.png" width=800 />

# Usage Instructions
* Export anenvironment variable named <code>ROS_WORKON_HOME</code> with the path containing all your workspaces or the installation of all your ROS distros using this command: <code>export ROS_WORKON_HOME="/opt/ros"</code>
* Source the <code>workon_ros_wrapper.sh</code> shell script with this command: <code> source /path/to/script/workon_ros_wrapper.sh</code>
* Add the above lines to the .bashrc scripts so they executed everytime a terminal is opened.
* Execute the following command to source the setup file of that ros_distro or workspace: <code>workon_ros distro_name</code>


