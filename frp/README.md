## 创建镜像
> `VERSION=0.58.1` 镜像版本
> 
> `ARCH=amd64` 系统架构，amd64 或 arm64
> 
> `APP=frps` 镜像类型，服务端frps 或 客户端frpc

```sh

docker build --build-arg VERSION=0.58.1 --build-arg ARCH=amd64 --build-arg APP=frps -t my_image:tag .

```
