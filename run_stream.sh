#!/bin/bash
# Runs the map and reduce files in this directory as a streaming Ruby Hadoop job.
# Processes some stock trade data that's in hdfs
# Dependencies:  start-all.sh to get Hadoop ecosystem running
# Usage: provide a number that will be the output directory name in hdfs; can't be already taken.
# See the details in the ruby files.
if [ $# -eq 0 ]
  then
    echo "No arguments supplied.  Please supply an output directory suffix name e.g. '7' to put output in /tmp/7 directory."
    exit 1
fi
clear
# hadoop dfs -cat /input/april4-thru-8-2011.csv |wc  # Show how many records will be processed

HADOOP_EXEC_HOME=/usr/local/bin/hadoop
JAR=/usr/local/Cellar/hadoop/1.1.2/libexec/contrib/streaming/hadoop-streaming-1.1.2.jar

HSTREAMING="$HADOOP_EXEC_HOME jar $JAR"

$HSTREAMING \
 -mapper  'ruby map.rb' \
 -reducer 'ruby reduce.rb' \
 -file map.rb \
 -file reduce.rb \
 -input '/input/april4-thru-8-2011.csv' \
 -output /tmp/$1
