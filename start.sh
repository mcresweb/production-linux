#!/bin/bash


cd ./nginx/sbin
nohup ./nginx &

cd ../../web
nohup node output/index.js &

cd ../server
nohup java -jar mcresweb.jar &
