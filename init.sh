#! /bin/bash

dir="$(pwd)"
rmsg() { echo -e "\033[31m$*\033[0m"; }
gmsg() { echo -e "\033[32m$*\033[0m"; }
bmsg() { echo -e "\033[34m$*\033[0m"; }

echo MRW-production-linux-initer


# 检测git
if ! command -v git >/dev/null 2>&1; then
    echo "git不存在 请先安装git"
    exit 1
else
    git --version
fi

# 检测java
if ! command -v java >/dev/null 2>&1; then
    echo "java不存在 请先安装java"
    exit 1
else
    echo "请确保java版本大于等于17"
    echo $(java -version 2>&1 |awk 'NR==1')
fi

# 检测node
if ! command -v node >/dev/null 2>&1; then
    echo "node不存在 请先安装node"
    exit 1
else
    echo "node version $(node -v)"
fi

# 检测npm
if ! command -v npm >/dev/null 2>&1; then
    echo "npm不存在 请先安装npm"
    exit 1
else
    echo "npm version $(npm -v)"
fi


# 创建server
cd $dir
mkdir server
cd ./server
wget -O build.sh https://raw.githubusercontent.com/mcresweb/production-linux/main/build-server.sh
sudo chmod a+x ./build.sh
wget -O application.properties https://raw.githubusercontent.com/mcresweb/production-linux/main/server-config.properties
bash ./build.sh
rmsg "成功构建server, 稍后您需要进入 $dir/server/application.properties 手动调整您的数据库信息"

# 创建web
cd $dir
git clone https://github.com/mcresweb/web.git web
cd ./web
wget -O build.sh https://raw.githubusercontent.com/mcresweb/production-linux/main/build-web.sh
sudo chmod a+x ./build.sh
npm run build
gmsg "成功构建web, 稍后您可以进入 $dir/web/config.yml 手动调整配置"

# 创建nginx
cd $dir
wget -qO- https://raw.githubusercontent.com/mcresweb/production-linux/main/install-nginx.sh | bash
gmsg "成功构建nginx, 稍后您可以进入 $dir/nginx/conf/nginx.conf 手动调整配置"


#下载脚本
cd $dir
wget -O start.sh https://raw.githubusercontent.com/mcresweb/production-linux/main/start.sh
wget -O close.sh https://raw.githubusercontent.com/mcresweb/production-linux/main/close.sh
sudo chmod a+x ./start.sh
sudo chmod a+x ./close.sh
bmsg "成功初始化项目"
bmsg "您可以使用start.sh和close.sh打开和关闭项目"