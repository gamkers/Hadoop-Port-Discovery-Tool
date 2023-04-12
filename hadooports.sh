#!/bin/bash
if [ "$1" = "-h"  -o "$1" = "--help" ]    
then                                       
  cat <<DOCUMENTATIONXX
NAME
       hadooports print the port of the process running on the hdfs
       on the standard output

SYNOPSIS
       hadooports [OPTION]...

DESCRIPTION
       Concatenate FILE(s), or standard input, to standard output.
       
       -r, --run
              to start the program

       -p, --process
              list out all the process

       -O, --output
              stores the output

       -pp, --privious-port
              display the privious port


AUTHOR
       Written by Akash M.

REPORTING BUGS
       Report hadooports bugs to akash.m@infocepts.com
       Apache Hadoop home page: <http://hadoop.apache.org/>

COPYRIGHT
       Copyright  ©  2023
       This is free software: you are free  to  change  and  redistribute  it.
       There is NO WARRANTY, to the extent permitted by law.

CREATED 
      Created on 12-04-2023:12:34

DOCUMENTATIONXX
exit $DOC_REQUEST

elif [ "$1" = "-p"  -o "$1" = "--process" ]     
then
array=($(sudo jps | cut -d " " -f 2))
for (( i= 0; i < ${#array[@]}; ++i)); do
position=$(($i+1))
echo "$position)${array[$i]}"
done

elif [ "$1" = "-o"  -o "$1" = "--output" ]    
then
array=($(sudo jps | cut -d " " -f 2))
for (( i= 0; i < ${#array[@]}; ++i)); do
position=$(($i+1))
echo "$position)${array[$i]}"
echo "${array[$i]}" >> names.txt
done
read -p "Specify the Process Number? " process
cat names.txt| head -n$process | tail -n 1 > port.txt
portnum=$(sudo jps | grep $(cat port.txt) | cut -d " " -f 1)
echo "$(cat port.txt)"
sudo netstat -nputl | grep "$portnum"| tee $2
rm names.txt

elif [ "$1" = "-r"  -o "$1" = "--run" ]     # Request help.
then
array=($(sudo jps | cut -d " " -f 2))
for (( i= 0; i < ${#array[@]}; ++i)); do
position=$(($i+1))
echo "$position)${array[$i]}"
echo "${array[$i]}" >> names.txt
done
read -p "Specify the Process Number? " process
cat names.txt| head -n$process | tail -n 1 > port.txt
portnum=$(sudo jps | grep $(cat port.txt) | cut -d " " -f 1)
echo "$(cat port.txt)"
sudo netstat -nputl | grep "$portnum"
rm names.txt

elif [ "$1" = "-pp"  -o "$1" = "--previous" ]     # Request help.
then
portnum=$(sudo jps | grep $(cat port.txt) | cut -d " " -f 1)
echo "$(cat port.txt)"
sudo netstat -nputl | grep "$portnum"

elif [ "$1" != "-r"  -o "$1" != "--run" -o "$1" != "-o"  -o "$1" != "--output" -o "$1" != "-p"  -o "$1" != "--process" -o  "$1" != "-pp"  -o "$1" != "--previous" ] 
then
echo "hadooports: invalid option -- h"
echo "Try hadooports --help for more information."

fi

