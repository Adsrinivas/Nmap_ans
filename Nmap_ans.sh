#! /bin/bash

# It is specially made for all Pentesters,Network Engineers

echo "                   Please wait the process is going to complete Shortly"
echo "          "
echo "          NOTE : You can see your OUTPUT at the end and also available in Results.txt"
echo "  "
# Get the octets from the network ip

ifconfig | grep "broadcast" | cut -d " " -f 10 | cut -d "." -f 1,2,3 | uniq > octet.txt

# set the variable to have the value of octet.txt

OCTET=$(cat octet.txt)

# Create new file .txt

echo "" > $OCTET.txt

# Loop

for ip in {1..254}

do
        ping -c 1 $OCTET.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d  ":" >> $OCTET.txt &
done


cat $OCTET.txt | sort > sorted_$OCTET.txt

echo "                  ↓↓↓↓↓ These are Ping supported Mechain Ip Addresses ↓↓↓↓↓"

cat sorted_$OCTET.txt

# Perform nmap scan.

echo "                                          "
nmap -p- -A -T4 -iL sorted_$OCTET.txt >> Results.txt

rm -r octet.txt $OCTET.txt sorted_$OCTET.txt
echo "          "
echo "                          ↓↓↓↓↓ Here is your Nmap Output ↓↓↓↓↓"

echo "          "

cat Results.txt

exit
