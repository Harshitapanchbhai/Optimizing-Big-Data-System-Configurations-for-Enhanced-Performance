FROM ubuntu:18.04
 
WORKDIR /root
 
#----- Install packages -----
RUN apt-get update
RUN apt-get install -y --no-install-recommends python2.7 ssh   
RUN apt-get install -y python-pip      
RUN pip install --upgrade pip virtualenv
RUN apt-get install -y --no-install-recommends openjdk-8-jdk-headless
RUN apt-get install -y --no-install-recommends git vim nano ranger
RUN apt-get install -y --no-install-recommends maven net-tools inetutils-ping
RUN apt-get install -y --no-install-recommends bc openssh-client
RUN apt-get install -y --no-install-recommends openssh-server wget
RUN apt-get install -y --no-install-recommends build-essential     

 
#----- Install hadoop 2.7.4 -----
COPY hadoop-3.3.5.tar.gz hadoop-3.3.5.tar.gz
RUN tar -xf hadoop-3.3.5.tar.gz
RUN rm hadoop-3.3.5.tar.gz

RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod 0600 ~/.ssh/authorized_keys

#----- Set environment variable 
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME=/root/hadoop-3.3.5
ENV HADOOP_MAPRED_HOME=/root/hadoop-3.3.5
ENV HADOOP_COMMON_HOME=/root/hadoop-3.3.5
ENV HADOOP_HDFS_HOME=/root/hadoop-3.3.5
ENV YARN_HOME=/root/hadoop-3.3.5
ENV HADOOP_INSTALL=/root/hadoop-3.3.5
ENV HADOOP_COMMON_LIB_NATIVE_DIR=/root/hadoop-3.3.5/lib/native
ENV HADOOP_OPTS="-Djava.library.path=/root/hadoop-3.3.5/lib/native"
ENV PATH=$PATH:/root/hadoop-3.3.5/bin:/root/hadoop-3.3.5/sbin

ENV YARN_NODEMANAGER_USER=root
ENV YARN_RESOURCEMANAGER_USER=root
ENV HDFS_NAMENODE_USER=root
ENV HDFS_DATANODE_USER=root
ENV HDFS_SECONDARYNAMENODE_USER=root
 
#----- Copy over config files -----
COPY config/* /tmp/
 
RUN mv /tmp/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml 
 
#----- Copy bechmarks and conex code -----
ADD HiBench /root/HiBench
ADD conexer /root/conexer

 
#----- Set new workdir to HiBench -----
WORKDIR /root/HiBench
 
 
#---- Change permissions of Hadoop binaries -----
# RUN chmod +x /root/start-hadoop.sh
RUN chmod +x $HADOOP_HOME/sbin/start-dfs.sh
RUN chmod +x $HADOOP_HOME/sbin/start-yarn.sh
 
#----- Format Namenode -----
# RUN $HADOOP_HOME/bin/hdfs namenode -format
 
# RUN ssh start service
 