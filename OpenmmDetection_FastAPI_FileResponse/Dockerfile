# FROM nvidia/cuda:11.1.1-runtime-ubuntu18.04
ARG PYTORCH="1.9.0"
ARG CUDA="11.1"
ARG CUDNN="8"

FROM pytorch/pytorch:${PYTORCH}-cuda${CUDA}-cudnn${CUDNN}-devel
ENV TORCH_CUDA_ARCH_LIST="All"
ENV TORCH_NVCC_FLAGS="-Xfatbin -compress-all"
ENV CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"

RUN apt-get update && apt-get install --allow-downgrades --allow-change-held-packages -y --no-install-recommends\
  wget ffmpeg libsm6 libxext6 python3.7-dev git -y

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
WORKDIR /usr/src/signature_extractor
RUN pip install torch==1.9.0+cu111 torchvision==0.10.0+cu111 -f https://download.pytorch.org/whl/torch_stable.html
RUN pip install mmcv-full==1.3.17 -f https://download.openmmlab.com/mmcv/dist/cu111/torch1.9.0/index.html
RUN git clone https://github.com/SwinTransformer/Swin-Transformer-Object-Detection.git
RUN cd Swin-Transformer-Object-Detection && pip install -r requirements/build.txt && pip install -v -e .
RUN rm -rf Swin-Transformer-Object-Detection
RUN pip install --upgrade numpy
RUN pip install "fastapi[all]"
ENTRYPOINT uvicorn server:app --host 0.0.0.0 --port 8526 --reload