# cpp builder image
FROM ubuntu:18.04 AS cppbuilder

# build dependencies
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    build-essential \
    cmake \
    git \
    libhwloc-dev \
    libssl-dev \
    libtool \
    libuv1-dev \
    wget 

# set workdir
WORKDIR /root
RUN git clone https://github.com/RagingTiger/xmrig.git && \
    cd xmrig/scripts && \
    ./build_deps.sh && \
    cd /root/xmrig && \
    mkdir build && \
    cd build && \
    cmake .. -DXMRIG_DEPS=scripts/deps -DCMAKE_BUILD_TYPE=Release && \
    make -j$(nproc)    

# xmrig production
FROM ubuntu:18.04 AS xmrig

COPY --from=cppbuilder /root/xmrig/build/xmrig /usr/bin/

# go builder image
FROM golang:alpine3.10 AS gobuilder

# get dependencies
RUN apk add --no-cache \
    git

# go get RUN apk --no-cache add
RUN go get -v -u ekyu.moe/cryptonight/cmd/cnhash

# pybuilder image
FROM alpine:3.10.5 AS pybuilder

# pull dependencies
RUN apk add --no-cache \
    build-base \
    cmake \
    make \
    gcc \
    git \
    python3-dev \
    python3=3.7.5-r1

# build py packages
RUN pip3 install -vvv --user py-cryptonight requests

# production
FROM alpine:3.10.5 AS production

# get python
RUN apk add --no-cache \
    python3=3.7.5-r1

# get pybuilder 
COPY --from=pybuilder /root/.local /root/.local
COPY --from=gobuilder /go/bin/ /usr/bin/
