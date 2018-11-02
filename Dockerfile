FROM ubuntu:16.04

# Prepare the environment
ADD init-docker.sh /opt
RUN chmod 777 /opt/init-docker.sh && \
  /opt/init-docker.sh 
ENV ZK_HOME /opt/zookeeper-3.4.12

# Add entrypoint
ADD entrypoint.sh $ZK_HOME/bin/
RUN chmod 777 $ZK_HOME/bin/entrypoint.sh

# Add zkGenConfig file
ADD zkGenConfig.sh $ZK_HOME/bin/
RUN chmod 777 $ZK_HOME/bin/zkGenConfig.sh

EXPOSE 2181 2888 3888
ENTRYPOINT ["/bin/bash", "-c" , "zkGenConfig.sh && exec zkServer.sh start-foreground"]
