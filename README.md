ROS_tools
=========

A repository with pieces of code to make life easier with ROS

bagfile_ext.sh: 

This script allows to extract the content of a rosbag file and convert it to a .csv file for each one of the topics specified
		
	Options: 
	-h  Displays help
	-o  Specify prefix for the output files
	-t  Specify topics to be extracted, specified as \"/topic1 \"topic2 ...
        In case no topic is specified all will be extracted
        