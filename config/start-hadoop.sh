#!/bin/bash

$HADOOP_HOME/bin/hdfs namenode -format

$HADOOP_HOME/sbin/start-dfs.sh

$HADOOP_HOME/sbin/start-yarn.sh
