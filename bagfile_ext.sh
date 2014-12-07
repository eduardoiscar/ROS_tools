
usage="
This script allows to extract the content of a rosbag file and convert it to a .csv file for each one of the topics specified
		
	Options: 
	-h  Displays help
	-o  Specify prefix for the output files
	-t  Specify topics to be extracted, specified as \"/topic1 \"topic2 ...
            In case no topic is specified all will be extracted
    "

#Needed to allow to kill the script with CTRL+C
trap "exit" INT

outfilename=
topiclist= 

#Parse the input arguments 
while [ $# -gt 0 ]
do
    case "$1" in
    -t)  topiclist="$2"
		 echo "$topiclist"
		 shift;;
	-o)  outfilename="$2"; shift;;
	-h)  echo "$usage"
		 exit 0;;
	--)	shift; break;;
	-*)
	    echo >&2 \
	    "usage: $0 [-t topics] [-o outfilename] [-h]"
	    exit 1;;
	*)  break;;	# terminate while loop
    esac
    shift 
done

#Check input bagfile name is non zero
if  [  -z "$1" ] ; then 
	echo "You must provide an input bagfile" 
	exit 1
elif [ -f "$1" ] ; then
	bagfilename="$1"
else
	echo "No bagfile found for $1.bag"
fi

#If no output file argument is provided, output file name is prefixed with inputfile name
if  [ -z "$outfilename" ] ; then
	outfilename=$bagfilename
fi

#If no topic arguments are provided, all topics are extracted from the file
if  [ -z "$topiclist" ]; then 
	echo "No topics"
	topiclist=$(rostopic list -b $bagfilename)
fi


echo "Exporting...  This may take a while"


for topic in $topiclist ;
do rostopic echo -p -b "$bagfilename" $topic >$outfilename-${topic//\//_}.csv ;
done


exit 0