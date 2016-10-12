# What is Alpine Linux?

![logo](logo.png)

[Alpine Linux](http://alpinelinux.org/) is a Linux distribution built around [musl libc](http://www.musl-libc.org/) and [BusyBox](http://www.busybox.net/).

This image is based on the well tested and documented [gliderlabs/alpine](http://gliderlabs.viewdocs.io/docker-alpine/) image.
This makes Alpine Linux a great image base for utilities and even production applications. [Read more about Alpine Linux here](https://www.alpinelinux.org/about/) and you can see how their mantra fits in right at home with Docker images.

# Included packages

To get you started, a set of packages have been integrated:

- curl
- wget
- ca-certificates
- bash
- tree

# Usage

Use this as base for your own containers:

```
FROM bandsintown/alpine
RUN apk-install <package_name>

CMD ["/bin/bash"]
```

or run it directly :

```
docker run -ti bandsintown/alpine
```

# Build

This project is configured as an [automated build in Dockerhub](https://hub.docker.com/r/bandsintown/alpine/).

Each branch give the related image tag.  

# License

All the code contained in this repository, unless explicitly stated, is
licensed under ISC license.

A copy of the license can be found inside the [LICENSE](LICENSE) file.
