# Dzzoffice

# 前提

在开始` Dzzoffice `部署之前，系统应该已安装` docker `和` docker-compose `。如果想把此项目与其他容器项目在系统上隔离开来，可尝试使用虚拟环境` virtualenv `。

# 制作镜像

```python
# 构建image
docker build -t registry.cn-shanghai.aliyuncs.com/tengfeiwu/dzzoffice:2.02.1 .
# push image
docker push registry.cn-shanghai.aliyuncs.com/tengfeiwu/dzzoffice:2.02.1
```
# 部署 dzzoffice

```python
# 获取源码
git clone https://gitee.com/tengfeiwu/development-tools.git
# 创建挂载目录
cd development-tools/Dzzoffice
mkdir mysql html
# 
```