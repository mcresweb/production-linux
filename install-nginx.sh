#安装依赖
yum -y install gcc zlib zlib-devel pcre-devel openssl openssl-devel

#下载解压
wget http://nginx.org/download/nginx-1.23.0.tar.gz
tar -xvf nginx-1.23.0.tar.gz
mv ./nginx-1.23.0 ./nginx
rm -rf ./nginx-1.23.0.tar.gz

#安装
cd ./nginx
./configure --with-http_stub_status_module --with-http_ssl_module
make
make install

#配置
cd ./conf
wget -O nginx.conf https://github.com/mcresweb/production-linux/blob/main/nginx.conf
cd ..


cd ..