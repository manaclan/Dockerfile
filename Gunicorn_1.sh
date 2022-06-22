CONTAINER_NAME=finger_print_enhance
docker kill ${CONTAINER_NAME}
docker rm ${CONTAINER_NAME}
DOCKER_BUILDKIT=1 docker build -t ${CONTAINER_NAME} .
docker run --name ${CONTAINER_NAME}  --restart unless-stopped -d -it -p 5000:5000  \
	-v $(pwd):/usr/src/ \
	${CONTAINER_NAME} \
  /bin/bash -c "cd src && conda run --no-capture-output -n sigenv gunicorn -w 4 -b 0.0.0.0:5000 api:app"
  # dont use 127.0.0.1, use 0.0.0.0
  #https://stackoverflow.com/a/62309026/7828101