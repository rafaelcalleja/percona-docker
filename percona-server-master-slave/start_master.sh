REPLICASET_NAME=${REPLICASET_NAME:-replset1}
NODE_NAME=${NODE_NAME:-${REPLICASET_NAME}_master}
NETWORK_NAME=${REPLICASET_NAME}_net

docker network create --driver overlay --attachable $NETWORK_NAME

  echo "Starting new node..."
docker run -d --rm -p 3306:3306 --net=$NETWORK_NAME \
         --name=$NODE_NAME \
	 -e MYSQL_ROOT_PASSWORD=Theistareyk \
	 rafaelcalleja/perconse-master-slave:5.7 --innodb-buffer-pool-size=2G --general-log=1 --general_log_file=/var/lib/mysql/general.log
#--gtid-mode=ON --enforce-gtid-consistency 
echo "Started $(docker ps -l -q)"

