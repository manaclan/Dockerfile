FROM nvidia/cuda:11.1.1-runtime-ubuntu18.04


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
RUN conda create -n open-mmlab python=3.7 -y
SHELL ["conda", "run", "--no-capture-output", "-n", "open-mmlab", "/bin/bash", "-c"]
RUN conda install pytorch==1.8.0 torchvision==0.9.0 cudatoolkit=11.1 -c pytorch -c conda-forge
RUN pip install mmcv-full==1.3.0 -f https://download.openmmlab.com/mmcv/dist/cu111/torch1.8.0/index.html
WORKDIR /usr/src/signature_extractor
COPY Swin-Transformer-Semantic-Segmentation Swin-Transformer-Semantic-Segmentation
RUN cd Swin-Transformer-Semantic-Segmentation && pip install -e .
RUN pip install "fastapi[all]"
ENTRYPOINT uvicorn server:app --host 0.0.0.0 --port 8526 --reload
# ENTRYPOINT [ "/bin/bash"]