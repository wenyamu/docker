部署容器
```bash
docker volume create my_hexo_data
docker run -it --name my_hexo_container -p 4000:4000 -v hexo_data:/home/hexo/.hexo hexo镜像源
```

访问 `http://0.0.0.0:4000`

# docker-compose.yml
访问 `https://git.dsme.cc/taskbjorn/docker-hexo/compose/docker-compose.yml`

# 使用

```bash
docker exec my_hexo_container hexo <command>
```

# 进入容器

```bash
docker exec -it my_hexo_container sh
hexo generate
```
