FROM continuumio/anaconda3

MAINTAINER Sarunas Girdenas sgirdenas@gmail.com

USER root

RUN apt-get update && \
    sed -i 's/exit 101/exit 0/' /usr/sbin/policy-rc.d && \
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
RUN python3 -m pip install wheel
RUN pip install --upgrade --force-reinstall pip==9.0.3

RUN apt-get install -y build-essential libssl-dev libffi-dev python-dev
RUN apt-get install -y libgmp-dev
RUN apt-get install -y libmpfr-dev
RUN apt-get install -y libmpc-dev

RUN apt-get install -y python-pip python-dev

# Install JupyterLab
RUN pip install jupyterlab && jupyter serverextension enable --py jupyterlab

WORKDIR "/root/"

# run
CMD EXPOSE 8888
# can change the --NotebookApp.token to have better password/token
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token="secret_stuff"

