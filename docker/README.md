# Docker GPU

Container with GPU support requires NVidia GPU (CUDA compatible) and NVidia Container Runtime.


## Setup

Based on image:

`nvidia/cuda:10.1-cudnn7-devel-ubuntu16.04`.

https://hub.docker.com/r/nvidia/cuda/

(compatible with TensorFlow GPU package and Julia GPU packages)

Requirements:

* NVidia Driver at least 410
* NVidia Container Runtime

...

Install NVidia Driver.

https://launchpad.net/~graphics-drivers/+archive/ubuntu/ppa

(at least 410 is required for CUDA 10.1)

...

Install Docker Engine (>=19.03) and NVidia Container Runtime.

https://docs.docker.com/install/linux/docker-ce/ubuntu/

https://github.com/NVIDIA/nvidia-container-runtime

Edit `/etc/docker/daemon.json`:

```json
{
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    },
    "default-runtime": "nvidia"
}
```

...
