部署容器
```bash
docker volume create my_hexo_data
docker run -itd --name my_hexo -p 4000:4000 -v hexo_data:/home/hexo/.hexo 你的hexo镜像源
```
访问 `http://0.0.0.0:4000`

在容器外使用命令
```bash
docker exec my_hexo <command>

#例如：hexo -v
docker exec my_hexo hexo -v
#打印版本信息，相当于进入容器后，执行 hexo -v

#再或者 ls -al
docker exec my_hexo ls -al
#打印目录信息
```

进入容器
```bash
docker exec -it my_hexo sh
hexo generate
```

以root用户进入容器
```bash
docker exec -it -u root my_hexo sh
hexo generate
```
安装主题
> https://theme-stun.github.io/docs/zh-CN/guide/quick-start.html

在 Hexo 根目录下，执行指令：
```sh
~/.hexo $ git clone https://github.com/liuyib/hexo-theme-stun.git themes/stun
```

常用命令
https://hexo.io/zh-cn/docs/commands
```bash
hexo server   #启动hexo服务
hexo clean    #清除缓存文件 (db.json) 和已生成的静态文件 (public)
hexo generate 简写 hexo g #生成静态文件
hexo deploy   简写 hexo d #部署到远程Github仓库
```
