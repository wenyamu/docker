FROM alpine:3.15

ARG VERSION
ARG ARCH
ARG APP

ENV FRP_VERSION $VERSION
ENV CPU_ARCH $ARCH
ENV FRP_APP $APP

RUN apk add --no-cache curl \
    && curl -L "https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_${CPU_ARCH}.tar.gz" -o frp.tar.gz \
    && mkdir -p /tmp/frp_files \
    && tar -zxC /tmp/frp_files -f frp.tar.gz \
    && rm frp.tar.gz \
    && mv /tmp/frp_files/frp_${FRP_VERSION}_linux_${CPU_ARCH}/${FRP_APP} /usr/bin/${FRP_APP} \
    && mkdir -p /etc/frp \
    && mv /tmp/frp_files/frp_${FRP_VERSION}_linux_${CPU_ARCH}/${FRP_APP}.toml /etc/frp/${FRP_APP}.toml \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && apk del curl

CMD ["${FRP_APP}", "-c", "/etc/frp/${FRP_APP}.toml"]
