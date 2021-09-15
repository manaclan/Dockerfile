FROM pytorch/pytorch:1.5-cuda10.1-cudnn7-runtime

RUN apt-get update && apt-get install zsh git curl wget vim -y
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN echo "if test -t 1; then\nexec zsh\nfi" > ~/.bashrc
RUN . ~/.bashrc
RUN conda init zsh
WORKDIR /usr/src
ENTRYPOINT [ "/bin/bash"]