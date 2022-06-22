CONTAINER_NAME=face_rotater
docker kill ${CONTAINER_NAME}
docker rm ${CONTAINER_NAME}
DOCKER_BUILDKIT=1 docker build -t ${CONTAINER_NAME} .
docker run --name ${CONTAINER_NAME}  --gpus '"device=0,1"' --restart unless-stopped -d -it -p 8171:8171  \
	-v $(pwd):/usr/src/rotater/ \
	${CONTAINER_NAME}
  