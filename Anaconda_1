FROM nvidia/cuda:11.2.1-runtime-ubuntu18.04


RUN apt-get update && apt-get install --allow-downgrades --allow-change-held-packages -y --no-install-recommends\
  wget ffmpeg libsm6 libxext6 -y

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p ~/miniconda 
RUN rm ~/miniconda.sh
RUN echo ". ~/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc
RUN echo "conda activate" >> ~/.bashrc
SHELL [ "/bin/bash", "--login", "-c" ]
ENV PATH="/root/miniconda/bin:$PATH"
RUN source ~/.bashrc
WORKDIR /usr/src/rotater/
COPY RetinaFace-tf2 ./RetinaFace-tf2
COPY saved_model ./saved_model
COPY yolov5 ./yolov5
COPY environment.yml ./
COPY hubconf.py ./
RUN conda env create -f environment.yml
WORKDIR /usr/src/rotater/
CMD conda activate env
