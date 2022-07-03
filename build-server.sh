#! /bin/bash

echo 当前目录:
pwd


echo ==========
echo 开始下载仓库
echo ==========

# loc: /mcresweb/server
if [ -d "./repo" ]; then
    cd ./repo
    git fetch --all
    git reset --hard origin/master
    git pull
    cd ..
else
    git clone https://github.com/mcresweb/Server2.git repo
fi


echo ==========
echo 开始构建jar
echo ==========

cd ./repo #loc: /mcresweb/server/repo
sudo chmod u+x ./mvnw
./mvnw -Dmaven.test.skip=true package clean package


echo ==========
echo 移动文件
echo ==========

cd ./target #loc: /mcresweb/server/repo/target
find . -name 'mcresweb-*.jar' -exec mv {} ../../mcresweb.jar \;

cd ../../ #loc: /mcresweb/server