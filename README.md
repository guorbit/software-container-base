# Purpose
This repository contains the container images for the orbit-software team. 
All teams default to the base image unless there are separate requirements for a team, in which case a new image will be created.

# Usage
## Gradient ML
These images are intended to be used on the Paperspace Gradient platform.
There these images can be imported in the advanced section the referencing the newest image release on dockerhub.

## Local
If you need to run the images locally make sure the local docker engine is configured with all the nvidia drivers as well (as all the images compiled for gpu usage)
Then you can compile the image like
```
docker build .
```
or
```
docker build -t <some name>:<some version>
```
Note: you can set anything as name and also as version it doesn't change how the container operates

After building the image you can start it using either terminal or docker desktop
