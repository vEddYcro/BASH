#!/bin/bash
host=$(hostname)
rm -rf /tmp/*.log
rm -rf /tmp/*.txt
rm -rf /fiologs/log/$host-count.txt
vmnumber=$1
count=0
echo 0 > /fiologs/log/c0unt.txt
echo "VM number: "$vmnumber
echo "DD 64K WRITE"
dd if=/dev/zero of=/64k-storage/test bs=512M count=37 oflag=direct 2>/tmp/dd-64k-write.txt
cat /tmp/dd-64k-write.txt | grep copied > /tmp/dd-64k-write-new.txt
awk '{s=$8} END {print s}' /tmp/dd-64k-write-new.txt > /fiologs/log/$host-dd-64k-write-final.txt
echo 1 > /fiologs/log/$host-count.txt
sleep 5

if [ $host = "testvm-centos-vm1" ]; then
	counts=''
	counts=$(ls /fiologs/log/testvm*count.txt)
	c2=0
	for file in $counts;
	do
	c1=$(awk '{s+=$1} END {print s}' $file)
	c2=$(python -c "print $c2 + $c1")
	done
	echo $c2 > /fiologs/log/c0unt.txt
fi

count=$(awk '{s+=$1} END {print s}' /fiologs/log/c0unt.txt)
echo "The number is "$count
until [ $count = $vmnumber ]
do
echo "Not done, wait for 5s..."
echo "Done at this moment: "$count"/"$vmnumber" VMova"
sleep 5
count=$(awk '{s+=$1} END {print s}' /fiologs/log/c0unt.txt)
done



if [ $host = "testvm-centos-vm1" ]; then
sleep 5
echo 0 > /fiologs/log/c0unt.txt
rm -rf /fiologs/log/testvm*count.txt
fi

echo "DD 64K READ"
sudo /sbin/sysctl -w vm.drop_caches=3
dd if=/64k-storage/test of=/dev/zero bs=512M count=37 2>/tmp/dd-64k-read.txt
cat /tmp/dd-64k-read.txt | grep copied > /tmp/dd-64k-read-new.txt
awk '{s=$8} END {print s}' /tmp/dd-64k-read-new.txt > /fiologs/log/$host-dd-64k-read-final.txt
sleep 5
echo 1 > /fiologs/log/$host-count.txt
sleep 5

if [ $host = "testvm-centos-vm1" ]; then
c2=0
counts=''
	counts=$(ls /fiologs/log/testvm*count.txt)
	for file in $counts;
	do
	c1=$(awk '{s+=$1} END {print s}' $file)
	c2=$(python -c "print $c2 + $c1")
	done
	echo $c2 > /fiologs/log/c0unt.txt
fi

count=$(awk '{s+=$1} END {print s}' /fiologs/log/c0unt.txt)

until [ $count = $vmnumber ]
do
echo "Not yet done, wait for 5s..."
echo "Done at this moment: "$count"/"$vmnumber" VMova"
sleep 5
count=$(awk '{s+=$1} END {print s}' /fiologs/log/c0unt.txt)
done


if [ $host = "testvm-centos-vm1" ]; then
sleep 5
echo 0 > /fiologs/log/c0unt.txt
rm -rf /fiologs/log/testvm*count.txt
fi

echo "DD 8K WRITE"
dd if=/dev/zero of=/8k-storage/test bs=512M count=37 oflag=direct 2>/tmp/dd-8k-write.txt
cat /tmp/dd-8k-write.txt | grep copied > /tmp/dd-8k-write-new.txt
awk '{s=$8} END {print s}' /tmp/dd-8k-write-new.txt > /fiologs/log/$host-dd-8k-write-final.txt
sleep 5
echo 1 > /fiologs/log/$host-count.txt
sleep 5

if [ $host = "testvm-centos-vm1" ]; then
count=$(awk '{s+=$1} END {print s}' /fiologs/log/c0unt.txt)
	c2=0
	counts=''
	counts=$(ls /fiologs/log/testvm*count.txt)
	for file in $counts;
	do
	c1=$(awk '{s+=$1} END {print s}' $file)
	c2=$(python -c "print $c2 + $c1")
	done
	echo $c2 > /fiologs/log/c0unt.txt
	count=$(awk '{s+=$1} END {print s}' /fiologs/log/c0unt.txt)
fi

count=$(awk '{s+=$1} END {print s}' /fiologs/log/c0unt.txt)


until [ $count = $vmnumber ]
do
echo "Not yet done, wait for 5s..."
echo "Done at this moment: "$count"/"$vmnumber" VMova"
sleep 5
count=$(awk '{s+=$1} END {print s}' /fiologs/log/c0unt.txt)
done


if [ $host = "testvm-centos-vm1" ]; then
sleep 5
echo 0 > /fiologs/log/c0unt.txt
rm -rf /fiologs/log/testvm*count.txt
fi


echo "DD 8K READ"
sudo /sbin/sysctl -w vm.drop_caches=3
dd if=/8k-storage/test of=/dev/zero bs=512M count=37 2>/tmp/dd-8k-read.txt
cat /tmp/dd-8k-read.txt | grep copied > /tmp/dd-8k-read-new.txt
awk '{s=$8} END {print s}' /tmp/dd-8k-read-new.txt > /fiologs/log/$host-dd-8k-read-final.txt
sleep 5
echo 1 > /fiologs/log/$host-count.txt

sleep 5
count=$(awk '{s+=$1} END {print s}' /fiologs/log/c0unt.txt)

#-----------------------------
if [ $host = "testvm-centos-vm1" ]; then
	c2=0
	counts=''
	counts=$(ls /fiologs/log/testvm*count.txt)
	for file in $counts;
	do
	c1=$(awk '{s+=$1} END {print s}' $file)
	c2=$(python -c "print $c2 + $c1")
	done
	echo $c2 > /fiologs/log/c0unt.txt
fi


until [ $count = $vmnumber ]
do
echo "Not yet done, wait for 5s..."
echo "The number is: "$count
sleep 5
count=$(awk '{s+=$1} END {print s}' /fiologs/log/c0unt.txt)
done


if [ $host = "testvm-centos-vm1" ]; then
sleep 5
rm -rf /fiologs/log/c0unt.txt
rm -rf /fiologs/log/testvm*count.txt
fi


echo ""
echo ""
echo ""
echo ""
echo ""
echo "READ-8-8"
fio read-8-8.fio
awk '{s+=$2} END {print s/976.236}' /tmp/read-8-8_bw.log > /fiologs/log/$host-read-bw-8-8.txt
awk '{s+=$2} END {print s}' /tmp/iops-8-8_iops.log > /fiologs/log/$host-read-IOPS-8-8.txt

echo ""
echo ""
echo ""
echo ""
echo ""
echo "READ-8-64"
fio read-8-64.fio
awk '{s+=$2} END {print s/976.236}' /tmp/read-8-64_bw.log > /fiologs/log/$host-read-bw-8-64.txt
awk '{s+=$2} END {print s}' /tmp/iops-8-64_iops.log > /fiologs/log/$host-read-IOPS-8-64.txt

echo ""
echo ""
echo ""
echo ""
echo ""
echo "READ-64-8"
fio read-64-8.fio
awk '{s+=$2} END {print s/976.236}' /tmp/read-64-8_bw.log > /fiologs/log/$host-read-bw-64-8.txt
awk '{s+=$2} END {print s}' /tmp/iops-64-8_iops.log > /fiologs/log/$host-read-IOPS-64-8.txt

echo ""
echo ""
echo ""
echo ""
echo ""
echo "READ-64-64"
fio read-64-64.fio
awk '{s+=$2} END {print s/976.236}' /tmp/read-64-64_bw.log > /fiologs/log/$host-read-bw-64-64.txt
awk '{s+=$2} END {print s}' /tmp/iops-64-64_iops.log > /fiologs/log/$host-read-IOPS-64-64.txt

echo ""
echo ""
echo ""
echo ""
echo ""
echo "WRITE-8-8"
fio write-8-8.fio
awk '{s+=$2} END {print s/976.236}' /tmp/write-8-8_bw.log > /fiologs/log/$host-write-bw-8-8.txt
awk '{s+=$2} END {print s}' /tmp/write-iops-8-8_iops.log > /fiologs/log/$host-write-IOPS-8-8.txt

echo ""
echo ""
echo ""
echo ""
echo ""
echo "WRITE-8-64"
fio write-8-64.fio
awk '{s+=$2} END {print s/976.236}' /tmp/write-8-64_bw.log > /fiologs/log/$host-write-bw-8-64.txt
awk '{s+=$2} END {print s}' /tmp/write-iops-8-64_iops.log > /fiologs/log/$host-write-IOPS-8-64.txt

echo ""
echo ""
echo ""
echo ""
echo ""
echo "WRITE-64-8"
fio write-64-8.fio
awk '{s+=$2} END {print s/976.236}' /tmp/write-64-8_bw.log > /fiologs/log/$host-write-bw-64-8.txt
awk '{s+=$2} END {print s}' /tmp/write-iops-64-8_iops.log > /fiologs/log/$host-write-IOPS-64-8.txt

echo ""
echo ""
echo ""
echo ""
echo ""
echo "WRITE-64-64"
fio write-64-64.fio
awk '{s+=$2} END {print s/976.236}' /tmp/write-64-64_bw.log > /fiologs/log/$host-write-bw-64-64.txt
awk '{s+=$2} END {print s}' /tmp/write-iops-64-64_iops.log > /fiologs/log/$host-write-IOPS-64-64.txt

echo ""
echo ""
echo ""
echo ""
echo ""
echo "IOPING in action"
echo "--------------"
echo ""
echo "IOPING DIRECT 8K"
ioping -c 100 -D /8k-storage/ | grep min/avg/max > /fiologs/log/$host-IOPING-DIRECT-8K.txt
echo "...done!"
echo ""
echo "IOPING CACHED 8K"
ioping -c 100 -C /8k-storage/ | grep min/avg/max > /fiologs/log/$host-IOPING-CACHED-8K.txt
echo "...done!"
echo ""
echo "IOPING DIRECT 64K"
ioping -c 100 -D /64k-storage/ | grep min/avg/max > /fiologs/log/$host-IOPING-DIRECT-64K.txt
echo "...done!"
echo ""
echo "IOPING CACHED 64K"
ioping -c 100 -C /64k-storage/ | grep min/avg/max > /fiologs/log/$host-IOPING-CACHED-64K.txt
echo "...done!"

sleep 5

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
	
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*dd-8k-write-final*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/DD/dd-8k-write.txt
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*dd-64k-write-final*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/DD/dd-64k-write.txt
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*dd-8k-read-final*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/DD/dd-8k-read.txt
	
	i=0
	j=0
	FILES=''
	FILES=$(ls /fiologs/log/*dd-64k-read-final*)
	for file in $FILES;
	do
	j=$(awk '{s+=$1} END {print s}' $file)
	i=$(python -c "print $i + $j")
	done
	echo $i > /fiologs/log/TOTAL/DD/dd-64k-read.txt
	
fi
