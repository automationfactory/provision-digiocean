#!/bin/bash
input="inventory.yml"
while IFS= read -r var
do
   echo $var
 # ssh-copy-id root@$var
done < "$input"

