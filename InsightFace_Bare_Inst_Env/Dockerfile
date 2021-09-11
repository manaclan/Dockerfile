# FROM nvidia/cuda:11.2.1-runtime-ubuntu18.04
FROM nvidia/cuda:11.1.1-runtime-ubuntu18.04


RUN apt-get update && apt-get install --allow-downgrades --allow-change-held-packages -y --no-install-recommends\
  wget ffmpeg libsm6 libxext6 g++ -y

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p ~/miniconda 
RUN rm ~/miniconda.sh
RUN echo ". ~/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc
RUN echo "conda activate" >> ~/.bashrc
SHELL [ "/bin/bash", "--login", "-c" ]
ENV PATH="/root/miniconda/bin:$PATH"
RUN source ~/.bashrc
WORKDIR /usr/src/rotater/
# COPY environment_scrfd.yml ./
RUN conda create -n face_rotater python==3.8 -y
# Below script run conda in docker
# ref: https://pythonspeed.com/articles/activate-conda-dockerfile/
# be caredful to specified --no-capture-output else nothing will be printed to docker logs
# citation: "conda run -n myenv yourcommand will run yourcommand inside the environment. 
# You’ll also want to pass the --no-capture-output flag to conda run so it streams stdout and stderr"
SHELL ["conda", "run", "--no-capture-output", "-n", "face_rotater", "/bin/bash", "-c"]
RUN pip install torch==1.8.0+cu111 torchvision==0.9.0+cu111 -f https://download.pytorch.org/whl/torch_stable.html
RUN pip install cython 
RUN  pip install -U insightface 
RUN  pip install mmcv-full -f https://download.openmmlab.com/mmcv/dist/cu111/torch1.8.0/index.html 
RUN  pip install mmdet && pip install -U insightface 
RUN  pip install onnxruntime-gpu==1.8.0 onnxruntime==1.8.0 
RUN pip install "fastapi[all]" imutils imgaug

COPY yolov5 yolov5
WORKDIR /usr/src/rotater/yolov5
RUN pip install -r requirements.txt
WORKDIR /usr/src/rotater/
ENTRYPOINT uvicorn server:app --reload --host 0.0.0.0 --port 8171
