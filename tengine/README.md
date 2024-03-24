### 部分源码修改自
https://github.com/Axizdkr/tengine/tree/master

> tengine-acme.sh

tengine + acme.sh 二合一
用 supervisor 管理 nginx 和 cron

### docker容器
```sh
docker run -itd \
-p 80:80 \
-v /root/out:/acme.sh \
-v /root/out/ssl:/acme.sh/ssl \
--name tacme \
tengine-acme.sh
```

### 申请ssl证书
#因为80端口被nginx占用，所以 `--standalone` 模式下要指定另外的端口 `--httpport 81`
```sh
docker exec tacme acme.sh --issue \
-d abc.com \
-d www.abc.com \
--standalone \
--httpport 81
```

### 复制证书到指定目录(此目录必须已经存在)
```sh
docker exec tacme acme.sh --install-cert \
-d abc.com \
--key-file       /acme.sh/ssl/key.pem \
--fullchain-file /acme.sh/ssl/fullchain.pem \
--cert-file      /acme.sh/ssl/cert.pem \
--ca-file        /acme.sh/ssl/ca.pem
```
