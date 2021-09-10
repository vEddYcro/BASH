#!/bin/bash
host=$(hostname)
rm -rf /tmp/*.log
echo ""
echo ""
echo ""
echo ""
echo ""
echo "READ-8-8"
fio read-8-8.fio
awk '{s+=$2} END {print s/977}' /tmp/read-8-8_bw.log > /fiologs/log/$host-read-bw-8-8.txt
awk '{s+=$2} END {print s}' /tmp/iops-8-8_iops.log > /fiologs/log/$host-read-IOPS-8-8.txt

echo ""
echo ""
echo ""
echo ""
echo ""
echo "READ-8-64"
fio read-8-64.fio
awk '{s+=$2} END {print s/977}' /tmp/read-8-64_bw.log > /fiologs/log/$host-read-bw-8-64.txt
awk '{s+=$2} END {print s}' /tmp/iops-8-64_iops.log > /fiologs/log/$host-read-IOPS-8-64.txt

echo ""
echo ""
echo ""
echo ""
echo ""
echo "READ-64-8"
fio read-64-8.fio
awk '{s+=$2} END {print s/977}' /tmp/read-64-8_bw.log > /fiologs/log/$host-read-bw-64-8.txt
awk '{s+=$2} END {print s}' /tmp/iops-64-8_iops.log > /fiologs/log/$host-read-IOPS-64-8.txt

echo ""
echo ""
echo ""
echo ""
echo ""
echo "READ-64-64"
fio read-64-64.fio
awk '{s+=$2} END {print s/977}' /tmp/read-64-64_bw.log > /fiologs/log/$host-read-bw-64-64.txt
awk '{s+=$2} END {print s}' /tmp/iops-64-64_iops.log > /fiologs/log/$host-read-IOPS-64-64.txt

echo ""
echo ""
echo ""
echo ""
echo ""
echo "WRITE-8-8"
fio write-8-8.fio
awk '{s+=$2} END {print s/977}' /tmp/write-8-8_bw.log > /fiologs/log/$host-write-bw-8-8.txt
awk '{s+=$2} END {print s}' /tmp/write-iops-8-8_iops.log > /fiologs/log/$host-write-IOPS-8-8.txt

echo ""
echo ""
echo ""
echo ""
echo ""
echo "WRITE-8-64"
fio write-8-64.fio
awk '{s+=$2} END {print s/977}' /tmp/write-8-64_bw.log > /fiologs/log/$host-write-bw-8-64.txt
awk '{s+=$2} END {print s}' /tmp/write-iops-8-64_iops.log > /fiologs/log/$host-write-IOPS-8-64.txt

echo ""
echo ""
echo ""
echo ""
echo ""
echo "WRITE-64-8"
fio write-64-8.fio
awk '{s+=$2} END {print s/977}' /tmp/write-64-8_bw.log > /fiologs/log/$host-write-bw-64-8.txt
awk '{s+=$2} END {print s}' /tmp/write-iops-64-8_iops.log > /fiologs/log/$host-write-IOPS-64-8.txt

echo ""
echo ""
echo ""
echo ""
echo ""
echo "WRITE-64-64"
fio write-64-64.fio
awk '{s+=$2} END {print s/977}' /tmp/write-64-64_bw.log > /fiologs/log/$host-write-bw-64-64.txt
awk '{s+=$2} END {print s}' /tmp/write-iops-64-64_iops.log > /fiologs/log/$host-write-IOPS-64-64.txt

sleep 5
rm -rf /tmp/*.log


if [ $host = "testvm-centos-vm1" ]; then
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*read-IOPS-8-8*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/read-IOPS-8-8.txt
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*read-bw-8-8*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/read-bw-8-8.txt
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*read-IOPS-8-64*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/read-IOPS-8-64.txt
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*read-bw-8-64*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/read-bw-8-64.txt
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*read-IOPS-64-8*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/read-IOPS-64-8.txt
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*read-bw-64-8*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/read-bw-64-8.txt
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*read-IOPS-64-64*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/read-IOPS-64-64.txt
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*read-bw-64-64*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/read-bw-64-64.txt
	
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*write-IOPS-8-8*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/write-IOPS-8-8.txt
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*write-bw-8-8*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/write-bw-8-8.txt
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*write-IOPS-8-64*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/write-IOPS-8-64.txt
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*write-bw-8-64*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/write-bw-8-64.txt
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*write-IOPS-64-8*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/write-IOPS-64-8.txt
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*write-bw-64-8*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/write-bw-64-8.txt
	
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*write-IOPS-64-64*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/write-IOPS-64-64.txt
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*write-bw-64-64*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/write-bw-64-64.txt
fi
