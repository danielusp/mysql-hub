#!/bin/bash

source .env

ERROR_MESSAGE="There is no ${CONTAINER_NAME} running."

### Verify if container is running
CONTAINER_STATUS=false
CONTAINER_STATUS=$(docker inspect -f '{{.State.Running}}' ${CONTAINER_NAME} 2>/dev/null)

### Options
PS3="Select an option: "
OP=(
    "[Server] MySQL 8.0.31"
	"[Server] MySQL 5.7.43"
	"[Server] MySQL 5.6"
	"[Server] MySQL 5.5"
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
    	"[Server] MySQL 8.0.31")
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
		"[Server] MySQL 5.7.43")
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
		"[Server] MySQL 5.6")
            # Stop a container if it's running
			if [ ${CONTAINER_STATUS} ]; then
				docker stop ${CONTAINER_NAME}
			fi

			docker volume create mysql-hub-5_6
			docker run -d --rm \
			--name ${CONTAINER_NAME} \
			-e MYSQL_USER=${USER} \
			-e MYSQL_PASSWORD=${PASS} \
			-e MYSQL_ROOT_PASSWORD=${ROOT_PASS} \
			-v mysql-hub-5_6:/var/lib/mysql \
			-v ${PWD}/configs/5.6:/etc/mysql/conf.d \
			-v ${PWD}/sources:/sources \
			mysql:5.6
			break
			;;
		"[Server] MySQL 5.5")
            # Stop a container if it's running
			if [ ${CONTAINER_STATUS} ]; then
				docker stop ${CONTAINER_NAME}
			fi

			docker volume create mysql-hub-5_5
			docker run -d --rm \
			--name ${CONTAINER_NAME} \
			-e MYSQL_USER=${USER} \
			-e MYSQL_PASSWORD=${PASS} \
			-e MYSQL_ROOT_PASSWORD=${ROOT_PASS} \
			-v mysql-hub-5_5:/var/lib/mysql \
			-v ${PWD}/configs/5.5:/etc/mysql/conf.d \
			-v ${PWD}/sources:/sources \
			mysql:5.5
			break
			;;
		"[Run] MySQL Client as user $USER")
            if [ ${CONTAINER_STATUS} ]; then
				docker exec -it ${CONTAINER_NAME} mysql -u ${USER} -p
			else
				echo $ERROR_MESSAGE
			fi
			break
			;;
		"[Run] MySQL Client as user root")
			if [ ${CONTAINER_STATUS} ]; then
				docker exec -it ${CONTAINER_NAME} mysql -u root -p
			else
				echo $ERROR_MESSAGE
			fi
			break
			;;
		"Enter into MySQL Server's container using Shell")
			if [ ${CONTAINER_STATUS} ]; then
				docker exec -it ${CONTAINER_NAME} /bin/bash
			else
				echo $ERROR_MESSAGE
			fi
			break
			;;
		"[Show] Container's IP")
			if [ ${CONTAINER_STATUS} ]; then
				IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${CONTAINER_NAME})

				echo "Container ${CONTAINER_NAME} has IP $IP"
			else
				echo $ERROR_MESSAGE
			fi

			break
			;;
    	"[Stop] MySQL Server")
			if [ ${CONTAINER_STATUS} ]; then
				docker stop ${CONTAINER_NAME}
			else
				echo $ERROR_MESSAGE
			fi
			break
			;;
		"[Remove] Volumes")
			docker volume rm mysql-hub-8_0_31
			docker volume rm mysql-hub-5_7_43
			docker volume rm mysql-hub-5_6
			docker volume rm mysql-hub-5_5
			break
			;;
		"Quit")
			break
			;;
		*) echo "Invalid $REPLY";;
	esac
done
