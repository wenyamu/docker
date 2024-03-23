FROM alpine:latest

# 安装所需的依赖项
RUN apk add --no-cache git nodejs npm rsync openssh

# 安装Hexo命令行
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
