CONTAINER_NAME=carime
docker kill ${CONTAINER_NAME}
docker rm ${CONTAINER_NAME}
DOCKER_BUILDKIT=1  docker build -t ${CONTAINER_NAME} .
docker run --name ${CONTAINER_NAME}  --gpus all -it --rm --ipc=host	-v $(pwd):/usr/src/ \
	${CONTAINER_NAME}