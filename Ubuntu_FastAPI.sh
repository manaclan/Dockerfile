CONTAINER_NAME=ocr_rule_api
sudo docker kill ${CONTAINER_NAME}
sudo docker rm ${CONTAINER_NAME}
sudo docker build -t ${CONTAINER_NAME} .
sudo docker run --name ${CONTAINER_NAME}  --restart unless-stopped -d -it -p 8517:8517  \
	-v $(pwd):/usr/src/ \
	${CONTAINER_NAME} \
  /bin/bash -c "conda run --no-capture-output -n ocr_rule_api uvicorn server:app --reload --port 8517"