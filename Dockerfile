FROM debian:stretch

MAINTAINER Sarunas Girdenas sgirdenas@gmail.com

USER root

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

# install tini
RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

RUN sed -i 's/exit 101/exit 0/' /usr/sbin/policy-rc.d && \
    apt-get install -yq --no-install-recommends \
    libffi-dev libblas-dev liblapack-dev \
    libopenblas-dev ca-certificates bzip2 unzip \
    libsm6 libzmq3-dev pandoc \
    texlive-latex-base texlive-latex-extra texlive-fonts-extra texlive-fonts-recommended \
    scala libxrender1 fonts-dejavu openjdk-8-jdk \
    build-essential libfreetype6-dev libxft-dev \
    libatlas-base-dev libpng-dev \
    libpython3-all-dev libpython-all-dev  \
    pandoc gfortran g++ git wget curl vim locate

# update pip
RUN apt-get install python3-pip -y
RUN pip3 install --upgrade pip setuptools

RUN apt-get install -y build-essential libssl-dev libffi-dev python-dev
RUN apt-get install -y libgmp-dev
RUN apt-get install -y libmpfr-dev
RUN apt-get install -y libmpc-dev

RUN apt-get install -y python-pip python-dev

# Install JupyterLab
RUN pip3 install jupyterlab && jupyter serverextension enable --py jupyterlab

WORKDIR "/root/"

# run
CMD EXPOSE 8888
# can change the --NotebookApp.token to have better password/token
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token="secret_stuff"