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
-v /root/ssl:/ssl \
--name tacme \
tengine-acme.sh
```

### 测试 acme.sh 是否正常运行
```sh
docker exec tacme acme.sh -v
#https://github.com/acmesh-official/acme.sh
#v3.0.8
```
### 申请ssl证书
#因为80端口被nginx占用，所以 `--standalone` 模式下要指定另外的端口 `--httpport 81`

#这里申请的是 一级域名 abc.com 和 二级域名 www.abc.com 的多域名证书。

#如果你在nginx中配置了 https://abc.com 跳转到 https://www.abc.com 则 二级域名 www.abc.com 不能缺少。
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

### 查看容器中定时任务
```sh
crontab -l
```
> 4 2 * * * "/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" --config-home "/acme.sh" > /proc/1/fd/1 2>/proc/1/fd/2
