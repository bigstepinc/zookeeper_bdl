FROM ubuntu:16.04

# Prepare the environment
ADD init-docker.sh /opt
RUN chmod 777 /opt/init-docker.sh && \
  /opt/init-docker.sh 
ENV ZK_HOME /opt/zookeeper-3.4.12

# Add zkGenConfig file
ADD zkGenConfig.sh $ZK_HOME/bin/
RUN chmod 777 $ZK_HOME/bin/zkGenConfig.sh && \
  cd $ZK_HOME && \
  export PATH=$PATH:$ZK_HOME/bin

# Add zkOk file
ADD zkOk.sh $ZK_HOME/bin/

EXPOSE 2181 2888 3888
ENTRYPOINT ["/bin/bash", "-c" , "$ZK_HOME/bin/zkGenConfig.sh && exec $ZK_HOME/bin/zkServer.sh start-foreground"]
