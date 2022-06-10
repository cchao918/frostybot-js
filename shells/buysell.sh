#/bin/bash
echo -n "stub:"
read stub
echo -n "symbol:"
read symbol

#echo -n "frostybot trade:markets  stub=$stub | grep \"symbol\" | grep  $symbol"
#echo -e '\n'

eval "frostybot trade:markets  stub=$stub | grep \"symbol\" | grep  $symbol"


if [ $? -ne 0 ]; then
    echo -e "\n连接失败\n"
else
    echo -e "        _e-e_           \n"
    echo -e "      _(-._.-)_         \n"
    echo -e "   .-(  \`---'  )-.      \n"
    echo -e "  __\\ \\\\\\___/// /__ \n"
    echo -e " '-._.'/M\\ /M\\\`._,-\`  \n"
    echo -e "\n连接成功\n"
    while true
    do
        echo -n "$stub=>"
        read  command

        if [[ "$command" == "exit" ]];then
            break
        fi
        commands=($command)

        if [[ "$command" == "" ]];then
            continue
        fi
        if [[ "${commands[0]}" != "buy" ]]  &&  [[ "${commands[0]}" != "sell" ]]   ;then
           echo -e "输入错误\n"
           continue
        fi

        echo -e "===${commands[0]}  $symbol : ${commands[1]}  ===\n"
        echo -e "frostybot trade:${commands[0]}  stub=$stub symbol=$symbol base=${commands[1]}\n"
        resulttxt= eval  "frostybot trade:${commands[0]}  stub=$stub symbol=$symbol base=${commands[1]} | grep -e \"result\" -e \"\\\"message\\\"\"  "
    done
    echo -e "成功退出"

fi
