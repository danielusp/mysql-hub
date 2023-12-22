#!/bin/bash

source .env

### Verify if container is running
CONTAINER_STATUS=false
CONTAINER_STATUS=$(docker inspect -f '{{.State.Running}}' ${CONTAINER_NAME} 2>/dev/null)

### Options
PS3="Select an option: "
OP=(
    "[Run] MySQL 8.0.31 Server"
	"[Run] MySQL 5.7.43 Server"
	"[Run] MySQL Client as user $USER"
	"[Run] MySQL Client as user root"
    "Enter into MySQL Server's container using Shell"
	"[Show] Container's IP"
	"[Stop] MySQL Server"
	"[Remove] Volumes"
	"Quit"
)

select OPT in "${OP[@]}"
do
	case $OPT in
    	"[Run] MySQL 8.0.31 Server")
			# Stop a container if it's running
			if [ ${CONTAINER_STATUS} ]; then
				docker stop ${CONTAINER_NAME}
			fi

			docker volume create mysql-hub-8_0_31
			docker run -d --rm \
			--name ${CONTAINER_NAME} \
			-e MYSQL_USER=${USER} \
			-e MYSQL_PASSWORD=${PASS} \
			-e MYSQL_ROOT_PASSWORD=${ROOT_PASS} \
			-v mysql-hub-8_0_31:/var/lib/mysql \
			-v ${PWD}/configs/8.0.31:/etc/mysql/conf.d \
			-v ${PWD}/sources:/sources \
			mysql:8.0.31
			break
			;;
		"[Run] MySQL 5.7.43 Server")
            # Stop a container if it's running
			if [ ${CONTAINER_STATUS} ]; then
				docker stop ${CONTAINER_NAME}
			fi

			docker volume create mysql-hub-5_7_43
			docker run -d --rm \
			--name ${CONTAINER_NAME} \
			-e MYSQL_USER=${USER} \
			-e MYSQL_PASSWORD=${PASS} \
			-e MYSQL_ROOT_PASSWORD=${ROOT_PASS} \
			-v mysql-hub-5_7_43:/var/lib/mysql \
			-v ${PWD}/configs/5.7:/etc/mysql/conf.d \
			-v ${PWD}/sources:/sources \
			mysql:5.7.43
			break
			;;
		"[Run] MySQL Client as user $USER")
            docker exec -it ${CONTAINER_NAME} mysql -u ${USER} -p
			break
			;;
		"[Run] MySQL Client as user root")
            docker exec -it ${CONTAINER_NAME} mysql -u root -p
			break
			;;
		"Enter into MySQL Server's container using Shell")
			docker exec -it ${CONTAINER_NAME} /bin/bash
			break
			;;
		"[Show] Container's IP")
			IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${CONTAINER_NAME})

			echo "Container ${CONTAINER_NAME} has IP $IP"

			break
			;;
    	"[Stop] MySQL Server")
			if [ ${CONTAINER_STATUS} ]; then
				docker stop ${CONTAINER_NAME}
			else
				echo "There is no ${CONTAINER_NAME} running."
			fi
			break
			;;
		"[Remove] Volumes")
			docker volume rm mysql-hub-8_0_31
			docker volume rm mysql-hub-5_7_43
			break
			;;
		"Quit")
			break
			;;
		*) echo "Invalid $REPLY";;
	esac
done
