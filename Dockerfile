# rebased/repackaged base image that only updates existing packages
FROM mbentley/ubuntu:22.04 AS build

# cache buster
ARG LIBRDB_VER

# noninteractive by default
ARG DEBIAN_FRONTEND=noninteractive

# install build dependencies
RUN apt-get update &&\
  apt-get install -y --no-install-recommends build-essential ca-certificates git libssl-dev

# git clone
RUN cd /tmp &&\
  git clone --depth 1 https://github.com/redis/librdb.git

# build librdb
RUN cd /tmp/librdb &&\
  export BUILD_TLS="yes" &&\
  make install


# final image with rdb-cli
# rebased/repackaged base image that only updates existing packages
FROM mbentley/ubuntu:22.04
LABEL maintainer="Matt Bentley <mbentley@mbentley.net>"

# bring over rdb-cli
COPY --from=build /usr/local/bin /usr/local/bin

CMD ["rdb-cli"]
