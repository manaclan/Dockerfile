CONTAINER_NAME=remove_background
docker kill ${CONTAINER_NAME}
docker rm ${CONTAINER_NAME}
docker build -t ${CONTAINER_NAME} .
docker run --name ${CONTAINER_NAME} --restart unless-stopped -d -it -p 8527:80  \
        -v $(pwd):/usr/src/RemoveBackground/ \
        ${CONTAINER_NAME}
docker logs -f ${CONTAINER_NAME}