ARG baseimage
FROM $baseimage

ARG hw_platform=cpu

SHELL ["/bin/sh", "-lxc"]

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y \
        --no-install-recommends \
        build-essential \
        sudo \
        bzip2 \
        curl \
        ca-certificates && \
    apt autoclean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -G sudo user && \
    passwd -d user && \
    echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user

USER user
WORKDIR /home/user

COPY --chown=user .cache .cache
COPY --chown=user setup setup
COPY --chown=user conf conf
COPY --chown=user bin bin
COPY --chown=user setup/jupyter_notebook_config.py /home/user/.jupyter/
RUN ~/setup/install.sh $hw_platform && \
    rm -rf .cache setup

EXPOSE 8888

CMD /home/user/bin/jupyter-lab
