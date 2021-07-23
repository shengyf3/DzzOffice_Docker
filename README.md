# 前提

在开始` Dzzoffice `部署之前，系统应该已安装` docker `和` docker-compose `。如果想把此项目与其他容器项目在系统上隔离开来，可尝试使用虚拟环境` virtualenv `。

当前使用的是` Dzzoffice:2.02.1 `最新版本。

# 下载源码

```python
# 获取源码
git clone https://gitee.com/tengfeiwu/dzzoffice.git
```

# 制作镜像

```python
# 构建image
docker build -t registry.cn-shanghai.aliyuncs.com/tengfeiwu/dzzoffice:2.02.1 .
# push image
docker push registry.cn-shanghai.aliyuncs.com/tengfeiwu/dzzoffice:2.02.1
```

说明：

*（1）如果想使用` Dzzoffice `其他版本，请自行在` Dockerfile `中替换对应版本即可。

*（2）如果不想自己` build `镜像可以直接使用我构建的，镜像已公开。

# 部署 Dzzoffice

## 创建挂载目录

```python
mkdir html/ mysql/
```
## 拷贝 html

```python
# 使用我们上面build的dzzoffice:2.02.1镜像
docker run -itd --name dzzoffice_temp registry.cn-shanghai.aliyuncs.com/tengfeiwu/dzzoffice:2.02.1
# 拷贝容器内文件
docker cp dzzoffice_temp:/var/www/html html/
```
## 启动服务

```python
# 后台运行
docker-compose up -d
# 查看状态
docker-compose ps
```
# Dzzoffice初始化

## 浏览器访问

```python
# 登陆链接
http://宿主机IP:1800
# 普通用户登陆入口：
http://宿主机IP:1800/user.php?mod=login
# 管理员登陆入口：
http://宿主机IP:1800/admin.php?mod=orguser
```

这里需要注意以下三点，具体如下：

## MySQL连接配置

[![](https://pic.imgdb.cn/item/60fa28955132923bf87e8a62.jpg)](https://pic.imgdb.cn/item/60fa28955132923bf87e8a62.jpg)

注意：

*（1）数据库服务器：由于我们使用的是容器部署，也为了方便，我这里直接使用的宿主机IP+容器映射出来的端口3307；

*（2）数据库名：dzzoffice 不需要手动在mysql创建；

*（3）数据库用户名：root，数据库密码：在` docker-compose `中有定义` MYSQL_ROOT_PASSWORD=gmtools `;

*（4）【可选】如果出现数据库链接拒绝，使用如下方法排查：

```python
# 进入mysql容器
docker exec -it dzzoffice_mysql_1 /bin/bash
# 登入mysql
mysql -uroot -pgmtools
# 查看授权
show grants for root@'%';
# 如果授权有问题，授权
grant all privileges on *.* to 'root'@'%' identified by 'gmtools';
# 刷新表
flush privileges;
```
## 应用启用

管理 --> 应用市场 --> 在应用市场内找到对应应用，单击一键安装；

管理 --> 应用市场 --> 已安装 中 点击启用按钮 启用此应用

[![](https://pic.imgdb.cn/item/60fa2c6d5132923bf8895965.jpg)](https://pic.imgdb.cn/item/60fa2c6d5132923bf8895965.jpg)

## 实现在线预览和编辑

管理 --> 应用市场 --> 在应用市场内找到` onlyoffice `应用 点击 一键安装，安装完后，你可以通过` http://ip:8000 `地址来测试onlyoffice是否安装成功，成功后进入下一步设置;

管理 --> 应用市场 --> 已安装 中 点击设置按钮 进入设置页面

[![](https://pic.imgdb.cn/item/60fa2d375132923bf88bb455.jpg)](https://pic.imgdb.cn/item/60fa2d375132923bf88bb455.jpg)
