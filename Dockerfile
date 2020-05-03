# go builder image
#FROM golang:alpine3.10 AS gobuilder

# production image
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
FROM alpine:3.10.5

# get python
RUN apk add --no-cache \
    python3=3.7.5-r1

# get pybuilder 
COPY --from=pybuilder /root/.local /root/.local
