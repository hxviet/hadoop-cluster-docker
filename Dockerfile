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
    mv /tmp/workers $HADOOP_HOME/etc/hadoop/workers


# create directories for hdfs namenode, datanode, and hadoop logs

RUN mkdir -p /tmp/hadoop/dfs/name && \
    mkdir -p /tmp/hadoop/dfs/data && \
    mkdir $HADOOP_HOME/logs


# set up passphraseless ssh

RUN mkdir -p .ssh && \
    ssh-keygen -t rsa -f .ssh/id_rsa -P '' && \
    cat .ssh/id_rsa.pub >> .ssh/authorized_keys && \
    chmod 0600 .ssh/authorized_keys && \
    mv /tmp/ssh_config .ssh/config


# add example MapReduce programs

RUN mv /tmp/start-hadoop.sh start-hadoop.sh && \
    mv /tmp/run-wordcount.sh run-wordcount.sh


# start SSH service and open a bash shell

CMD [ "sh", "-c", "service ssh start; bash"]
