CONTAINER_NAME=check_fake_id
sudo docker kill ${CONTAINER_NAME}
sudo docker rm ${CONTAINER_NAME}
sudo docker build -t ${CONTAINER_NAME} .
sudo docker run --name ${CONTAINER_NAME}  --restart unless-stopped -d -it -p 8517:8517  \
	-v $(pwd):/usr/src/ \
	${CONTAINER_NAME} \
  /bin/bash -c "conda run --no-capture-output -n ocr_rule_api python server.py"

#remember to avoid call uvicorn in command line, instead start it in server.py with address 0.0.0.0 to 
#avoid "connection reset by peer"