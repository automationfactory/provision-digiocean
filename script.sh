echo ""
echo "Running playbook to manage VMs on Digital Ocean"
sudo ansible-playbook digitalocean.yml

sleep 10s

rm inventory.yml
echo "[local]" > inventory.yml
echo "localhost ansible_connection=local" >> inventory.yml
echo "[digitalocean]" >> inventory.yml
chmod 655 inventory.yml

echo ""
echo "Fetch IPAddress information for VMs on Digital Ocean"
curl -X GET "https://api.digitalocean.com/v2/droplets" -H "Authorization: Bearer $TOKEN" | grep -o -P '.ip_address":".{0,16}' | sed -e 's/.*:"\(.*\)","/\1/' | sed -e 's/["",net"]*$//g' >> inventory.yml

sleep 5s

#!/bin/bash
input="inventory.yml"
while IFS= read -r var
do
  ssh-copy-id -o StrictHostKeyChecking=no root@$var
done < "$input"

sleep 5s

echo ""
echo "Running playbook for package deployment"
sudo ansible-playbook deploypckg.yml
