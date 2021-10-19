FROM ubuntu:latest 

LABEL maintainer="1494136313@qq.com"

RUN sed -i "s/archive.ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y curl git python3

WORKDIR /srv

RUN git clone https://hub.fastgit.org/Etuloser/ectl

RUN chmod +x /srv/ectl/ectl

######################
###  SETUP NEOVIM  ###
######################
RUN /srv/ectl/ectl install neovim

######################
### SETUP ZSH/TMUX ###
######################

RUN apt-get install -y zsh tmux && rm -rf /tmp/*

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN git clone https://hub.fastgit.org/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

COPY ./.tmux.conf /root/

COPY ./.zshrc /root/

######################
###  SETUP GOLANG  ###
######################
RUN /srv/ectl/ectl install golang

RUN go env -w GO111MODULE="on"

RUN go env -w GOPROXY="https://goproxy.io"

ENTRYPOINT ["tmux"]
