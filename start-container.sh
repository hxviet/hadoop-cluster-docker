#!/bin/bash

# Modified by Hoang Xuan Viet on 2023-12-10

# the default node number is 3
N=${1:-3}


# start new hadoop master container
if [ "$(sudo docker ps -aq -f name=hadoop-master)" ]; then
	echo "Removing existing container 'hadoop-master'"
	sudo docker rm -f hadoop-master
fi
echo "Starting hadoop-master container..."
sudo docker run -itd \
                --net=hadoop \
                -p 50070:50070 \
                -p 8088:8088 \
                --name hadoop-master \
                --hostname hadoop-master \
                hadoop


# start new hadoop slave containers
i=1
while [ $i -lt $N ]
do
	slave_container="hadoop-slave$i"
	if [ "$(sudo docker ps -aq -f name=$slave_container)" ]; then
		echo "Removing existing container '$slave_container'"
		sudo docker rm -f $slave_container
	fi
	echo "Starting hadoop-slave$i container..."
	sudo docker run -itd \
	                --net=hadoop \
	                --name $slave_container \
	                --hostname $slave_container \
	                hadoop
	i=$(( $i + 1 ))
done 

# get into hadoop master container
sudo docker exec -it hadoop-master bash
