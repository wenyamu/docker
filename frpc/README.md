## 创建镜像命令
```
docker build -t frpc:0.58.1 .
```

## frp 客户端 docker 镜像
> frpc客户端版本 0.58.1
> 
> 适用于CPU架构 arm64

## frps.toml 公网服务端配置文件
```frps.toml
bindPort = 7000
```

## frpc.toml 局域网客户端配置文件详解
```frpc.toml
############################
# 公网服务器开启端口: 6080 #
############################

# 官网 https://gofrp.org/zh-cn/docs/overview/

# 公网服务器ip
serverAddr = "88.218.238.208"
# 服务端frps与客户端frpc绑定进行通信的端口(此端口只作为两者通信用，具体应用还需要开启相应的端口)
serverPort = 7000

########################################## frp实现的负载均衡
### 注意：
### 正常情况下，每个tcp代理的 remotePort 不能一样。但是负载均衡时，远程端口要一样(端口不同就无法实现负载均衡了)
### group 值相同的代理，会以轮询的方式实现负载均衡
### groupKey 为可选项，如果有，则值必须要相同
### http://88.218.238.208:6080 --->>> 127.0.0.1:80
### 查看效果时，要有耐心，多刷新几次（快速点击F5键），不然看不到负载均衡切换效果
### 多个设备 name 值不能重复，要唯一；其它参数不用修改

[[proxies]]
name = "site001"
type = "tcp"
localIP = "127.0.0.1"
localPort = 80
## 原理 http://88.218.238.208:6080 --->>> 127.0.0.1:80
remotePort = 6080
loadBalancer.group = "web"
#loadBalancer.groupKey = "str123"
```