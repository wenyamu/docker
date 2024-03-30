#FROM alpine:latest
FROM alpine:3.19

# 安装所需的依赖项
#RUN apk add --update --no-cache git=2.38.5-r0 nodejs=18.17.1-r0 npm=9.1.2-r0 rsync=3.2.7-r0
RUN apk add --no-cache git nodejs npm rsync openssh

# 安装Hexo命令行
#RUN npm install hexo@6.3.0 hexo-cli@4.3.0 hexo-server@3.0.0 -g --unsafe-perm=true --loglevel=error
RUN npm install hexo-cli -g --unsafe-perm=true --loglevel=error

COPY hexo-entrypoint.sh /home/hexo/.docker/hexo-entrypoint.sh

RUN addgroup -S hexo -g 1000 && \
    adduser -S hexo -g '' -u 1000 -G hexo && \
    mkdir -p /home/hexo/.hexo && \
    chown hexo:hexo /home/hexo/.hexo && \
    # 为容器常驻脚本添加权限，不然无法执行，会导致容器无法启动
    chmod 755 /home/hexo/.docker/hexo-entrypoint.sh

RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

# 运行用户
USER hexo
# 工作目录，进入容器直接进入此目录
WORKDIR /home/hexo/.hexo
# 容器常驻脚本
ENTRYPOINT ["/bin/sh", "-c", "/home/hexo/.docker/hexo-entrypoint.sh"]
