FROM alpine:3.11
RUN apk add --no-cache \
    jq \
    lego \
    nghttp2 \
    s6
ENV LEGO_PATH /lego
COPY entrypoint /usr/local/sbin/docker-entrypoint
COPY service/ /service/
COPY nghttpx.conf /etc/nghttpx/
ENTRYPOINT [ "docker-entrypoint" ]
