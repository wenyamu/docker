#!/bin/sh

# 如果项目根目录 /home/hexo/.hexo 是空的, 就初始化博客并安装相关依赖包
if [ -z "$(ls)" ]; then
	hexo init
  npm install \
      hexo-admin \
      hexo-toc \
      hexo-abbrlink \
      hexo-renderer-pug \
      hexo-generator-search \
      hexo-deployer-rsync \
      hexo-deployer-git

fi

# 启动 hexo
hexo clean
hexo server
