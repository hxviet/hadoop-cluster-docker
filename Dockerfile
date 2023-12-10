# Modified by Hoang Xuan Viet on 2023-12-10


FROM ubuntu:18.04


LABEL maintainer="KiwenLau <kiwenlau@gmail.com>, Hoang Xuan Viet <60069200+hxviet@users.noreply.github.com>"


WORKDIR /root


# install openssh-server, openjdk, and wget

RUN apt-get update && apt-get install -y openssh-server openjdk-8-jdk-headless wget


# install hadoop 3.3.6

RUN wget https://archive.apache.org/dist/hadoop/core/hadoop-3.3.6/hadoop-3.3.6.tar.gz && \
    tar -xzvf hadoop-3.3.6.tar.gz && \
    mv hadoop-3.3.6 /usr/local/hadoop && \
    rm hadoop-3.3.6.tar.gz


# set environment variables

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME=/usr/local/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin


# add ssh and hadoop configuration files

COPY config/* /tmp/

RUN mv /tmp/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves


# create a non-root user `user1`

RUN useradd -ms /bin/bash user1

WORKDIR /home/user1


# create directories for hdfs namenode, datanode, and hadoop logs

RUN mkdir -p /tmp/hadoop/dfs/name && \
    mkdir -p /tmp/hadoop/dfs/data && \
    mkdir $HADOOP_HOME/logs && \
    chmod -R a+w /tmp/hadoop && \
    chmod -R a+w $HADOOP_HOME/logs


# set up passphraseless ssh

RUN mkdir -p home/user1/.ssh && \
    ssh-keygen -t rsa -f home/user1/.ssh/id_rsa -P '' && \
    cat home/user1/.ssh/id_rsa.pub >> home/user1/.ssh/authorized_keys && \
    chmod 0600 home/user1/.ssh/authorized_keys && \
    mv /tmp/ssh_config home/user1/.ssh/config

# add example MapReduce programs

RUN mv /tmp/start-hadoop.sh /home/user1/start-hadoop.sh && \
    mv /tmp/run-wordcount.sh /home/user1/run-wordcount.sh


# format namenode as non-root user `user1`

USER user1

RUN $HADOOP_HOME/bin/hdfs namenode -format


# start SSH service and open a bash shell

CMD [ "sh", "-c", "service ssh start; bash"]
