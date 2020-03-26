FROM arm64v8/alpine:3.11 AS base
COPY --from=multiarch/qemu-user-static:aarch64-4.2.0-6 /usr/bin/qemu-*-static /usr/bin/
RUN apk add --no-cache \
    jq \
    lego \
    nghttp2 \
    s6
RUN rm /usr/bin/qemu-*-static

FROM scratch
COPY --from=base / /
ENV LEGO_PATH /lego
COPY entrypoint /usr/local/sbin/docker-entrypoint
COPY service/ /service/
COPY nghttpx.conf /etc/nghttpx/
ENTRYPOINT [ "docker-entrypoint" ]
