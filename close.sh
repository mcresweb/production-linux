
function handle()
{
    echo -e '\n\n'
    echo "$1 进程信息"
    ps -ef | grep "$2" | grep -v grep
    if [ $? == 0 ]; then
        ps -ef | grep "$2" | grep -v grep | cut -c 9-15 | xargs kill
        echo '已结束'
    else
        echo '服务未运行!'
    fi
    echo -e '\n'
}

handle '前端(web)' 'node output/index.js'
handle '后端(server)' 'java -jar mcresweb.jar'