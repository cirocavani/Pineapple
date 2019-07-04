# Pineapple

Deep Learning with Julia.

## Setup

Two types of installation:

* `Local`: assumes an Linux 64 bits, install on a project folder (isolated from the rest of the system).
* `Docker`: uses an Ubuntu 16.04 LTS image to install the project.

Two types of hardware supported:

* `CPU`: install TensorFlow and Julia only with CPU support.
* `GPU`: install TensorFlow and Julia with GPU dependencies (NVidia).

...

Local install for CPU:

```sh
setup/install.sh cpu
```

Local install for GPU (requires CUDA 10.0 and cuDNN 7 installed):

```sh
setup/install.sh gpu
```

Docker install for CPU:

```sh
docker/build.sh cpu
```

Docker install for GPU (requires NVidia Docker as default runtime):

```sh
docker/build.sh gpu
```


## Jupyter

On a `local` setup:

```sh
bin/jupyter-lab
# will hold the terminal
# Ctrl-C terminate Jupyter Lab.
```

On a `docker` setup:

```sh
docker/run.sh gpu
# or 'docker/run.sh cpu'
# will return after the container is started
```

To terminate the docker container:

```sh
docker/shutdown.sh gpu
# or 'docker/shutdown.sh cpu'
```

In both cases, open `http://localhost:8888/` in the web browser to access Jupyter Lab.
