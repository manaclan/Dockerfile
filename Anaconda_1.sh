CONTAINER_NAME=face_rotater
sudo docker kill ${CONTAINER_NAME}
sudo docker rm ${CONTAINER_NAME}
sudo docker build -t ${CONTAINER_NAME} .
sudo docker run --name ${CONTAINER_NAME}  --gpus '"device=0,1"' --restart unless-stopped -d -it -p 8171:8171  \
	-v $(pwd)/debug:/usr/src/rotater/debug \
	${CONTAINER_NAME} \
  /bin/bash -c "conda run --no-capture-output -n env python yolov5/server.py"