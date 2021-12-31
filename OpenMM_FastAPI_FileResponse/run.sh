CONTAINER_NAME=signature_extractor
docker kill ${CONTAINER_NAME}
docker rm ${CONTAINER_NAME}
docker build -t ${CONTAINER_NAME} .
docker run --name ${CONTAINER_NAME}  --gpus all --restart unless-stopped -d -it -p 8526:8526  \
	-v $(pwd):/usr/src/signature_extractor/ \
	${CONTAINER_NAME}
# docker logs -f signature_extractor