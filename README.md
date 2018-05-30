# docker-confluence 

### confluence容器配置
#### 启动容器
```
docker run --name  confluence -d -p 8090:8090 -p 8091:8091 daocloud.io/marcus_li/confluence:latest
```
记录Service ID

#### 破解confluence
##### 复制并备份文件
```
docker cp confluence:/opt/atlassian/confluence/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.2.jar ./atlassian-extras-2.4.jar
```
##### 进入容器 并备份文件
```
 docker exec -u root -it confluence /bin/sh
 mv /opt/atlassian/confluence/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.2.jar  /opt/atlassian/confluence/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.2.jar.bak
```
##### 使用破解工具生成新的jar文件

输入Service ID，选择复制出来的jar文件，点击patch，点击gen，记录生成key重启要用
```
#linux需要GUI,也可以在windows使用keygen.bat
rackfile/iNViSiBLE/keygen.sh
#将一开始记录的Service ID 输入，name可以随意填写
#点击patch选择刚改名的文件点击.gen！生成key，则atlassian-extras-2.4.jar已经破解完成
```
##### 将atlassian-extras-2.4.jar改回atlassian-extras-decoder-v2-3.2.jar并复制回原先目录
```
docker cp atlassian-extras-decoder-v2-3.2.jar  confluence:/opt/atlassian/confluence/confluence/WEB-INF/lib/
```

##### 重启confluence容器
```
docker restart confluence
```

##### 刷新页面，填入刚生成的key, 破解完成，继续的后面配置


### 启动mysql容器
my.cnf配置
```
[client]

default-character-set=utf8


[mysql]

default-character-set=utf8


[mysqld]

character_set_server=utf8
collation-server=utf8_bin #confluence要求这样

transaction_isolation=READ-COMMITTED  #confluence要求这样
```

```
 docker run --name confluence-mysql -d -p 3307:3306  -e MYSQL_ROOT_PASSWORD=root -v  C:\Users\Marcus\study\docker-confluence\mysqlconf\:/etc/mysql/conf.d/ -v C:\Users\Marcus\study\docker-confluence\mysqldata:/var/lib/mysql  mysql:5.7
```
###创建confluence数据库
```
create database confluence character set utf8 collate utf8_bin;
```
