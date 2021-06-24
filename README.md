## WORKON_ROS

This tool was inspired by [virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/) which makes activating and managing virtual environments very easy. 
This script allows you to source setup.bash files for different ros distros or workspaces in a similar way and also displays the name of the current activated distro+workspace in the command prompt in parenthesis. (shown below)

<img src="https://user-images.githubusercontent.com/23265149/123334549-e629ae00-d560-11eb-952b-9b50163284fe.png" width=800 />
<img src="https://user-images.githubusercontent.com/23265149/123334561-e75adb00-d560-11eb-93dd-1d78a9fdce46.png" width=400 />


>Note: The script assumes that you have installed all your ROS distros in default `/opt/ros` path

## Usage Instructions
* Add an environment variable named `ROS_WORKON_HOME` with the path containing workspaces to your `.bashrc` like this: 
 <br>`export ROS_WORKON_HOME=$HOME/ros_workspaces`

* To source the `workon_ros_script.sh` shell script everytime you open a terminal, add the following to your `.bashrc` 
<br>`source /path/to/script/workon_ros_wrapper.sh`

* Source any distro or workspace using this command:
<br>`workon_ros distro_name/workspace_name`

## TO DO:
* support for multiple ROS_WORKON_HOME paths.
* deactive_ros function 
* Tab Completion

