CONTAINER_NAME=finger_print_enhance
sudo docker kill ${CONTAINER_NAME}
sudo docker rm ${CONTAINER_NAME}
sudo docker build -t ${CONTAINER_NAME} .
sudo docker run --name ${CONTAINER_NAME}  --restart unless-stopped -d -it -p 5000:5000  \
	-v $(pwd):/usr/src/ \
	${CONTAINER_NAME} \
  /bin/bash -c "cd src && conda run --no-capture-output -n sigenv gunicorn -w 4 -b 0.0.0.0:5000 api:app"
  # dont use 127.0.0.1, use 0.0.0.0
  #https://stackoverflow.com/a/62309026/7828101