# docker-android-build
A all-in-one Docker ready image to build Android locally. Requires Linux or macOS with Docker.

### Deploying and running our container
To create and run our container, we can use the following command syntax:
```
docker run -it --name <container_name> --hostname <hostname> -v <local_repo>:/repo -v <local_ccache>:/tmp/ccache --rm divadsn/android-build:latest
```

Now you are probably wondering what those arguments mean, right? Let me explain.

| Argument                  | Description                                                     |
|---------------------------|-----------------------------------------------------------------|
| `-it`                     | Allows docker to allocate a tty for the container process       |
| `--name <container_name>` | Identification name for our container                           |
| `--hostname <hostname>`   | Sets the specified name as containers hostname                  |
| `-v src:dest`             | Mounts `src` path on host or volume to `dest` path on container |
| `--rm`                    | Cleans up the container and removes after exit                  |

Example when using volumes:
```
docker run -it --name build --hostname buildbot -v build_repo:/repo -v build_ccache:/tmp/ccache --rm divadsn/android-build:latest
```

Example when using bind mounts:
```
docker run -it --name build --hostname buildbot -v /home/${USER}/build/repo:/repo -v /home/${USER}/build/ccache:/tmp/ccache --rm divadsn/android-build:latest
```

After the container has been created, you should be greeted with a message about sudo access and you should be able to execute commands as user `docker` in directory `/repo`. Now you can go ahead and initialize your local repository using `repo init` and sync the sources, everything is setup to be ready to use.
