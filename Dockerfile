FROM ubuntu:16.04

# Add versioning details
ADD version.json /opt

# Prepare the environment
ADD init-docker.sh /opt
RUN chmod 777 /opt/init-docker.sh && \
  /opt/init-docker.sh 
ENV ZK_HOME /opt/zookeeper-3.4.12

# Add entrypoint
ADD entrypoint.sh $ZK_HOME/bin/
RUN chmod 777 $ZK_HOME/bin/entrypoint.sh

EXPOSE 2181 2888 3888
ENTRYPOINT ["$ZK_HOME/bin/entrypoint.sh"]
