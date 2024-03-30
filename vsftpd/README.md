
vsftpd 多用户 docker 配置

## 创建镜像
#vsftpd:centos7 表示镜像名:标签名
#最后的.号表示Dockerfile文件在当前目录中
```sh
cd vsftpd-centos \
docker build -t vsftpd:centos7 .
```

## 部署 docker 容器
```sh
docker run -d \
-v /my/data/directory:/home/vsftpd \
-v /my/data/usersconfig:/etc/vsftpd/usersconfig \
-v /my/data/vsftpd.conf:/etc/vsftpd/vsftpd.conf \
-v /my/data/virtual_users.pwd:/etc/vsftpd/virtual_users.pwd \
-p 20:20 \
-p 21:21 \
-p 21100-21110:21100-21110 \
--name vsftpd \
--restart=always \
vsftpd:centos7
```

## 进入容器 添加用户和密码 （此步骤已经由 inotify 监控自动执行，这里仅做原理说明）
```sh
docker exec -it vsftpd bash \
echo -e "ljs\nljsljs" >> /etc/vsftpd/virtual_users.pwd
```

>#以下步骤也可直接重启容器实现
```sh
mkdir -p /home/vsftpd/ljs #创建用户的目录
cat > /etc/vsftpd/usersconfig/ljs << EOF
#此配置文件针对虚拟用户的个性配置，修改后用户重新登陆即可生效，不需要重启vsftpd服务
...
...
EOF
#设置目录权限，每次新建用户目录时，都要执行一次
chown -R www-data:www-data /home/vsftpd/
#重新生成数据库文件
/usr/bin/db_load -T -t hash -f /etc/vsftpd/virtual_users.pwd /etc/vsftpd/virtual_users.db
```
## supervisor
使用 supervisor 管理 vsftpd 和 inotify 进程 \
inotify 用来监控 /etc/vsftpd/virtual_users.pwd 文件，有新用户添加时就执行上面的4条命令，此新用户即可登陆ftp

