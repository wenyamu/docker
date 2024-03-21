部署容器
```bash
docker volume create my_hexo_data
docker run -itd --name my_hexo -p 4000:4000 -v hexo_data:/home/hexo/.hexo 你的hexo镜像源
```
访问 `http://0.0.0.0:4000`

使用
```bash
docker exec my_hexo hexo <command>
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
