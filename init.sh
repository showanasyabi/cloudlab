
#!/bin/bash

###  mount the the disk to path /mydata
sudo mkdir /mydata
echo yes | sudo mkfs.ext4 /dev/nvme0n1p4
sudo mount /dev/nvme0n1p4 /mydata

#### install docker
sudo apt update
echo yes yes | sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
echo yes | sudo apt install docker-ce

########## change the path of docker to /mydata
sudo service docker stop
printf '{\n"data-root": "/mydata/dockerData" \n}' >> daemon.json
sudo mv daemon.json  /etc/docker
sudo rsync -aP /var/lib/docker/ /mydata/dockerData
sudo mv /var/lib/docker /var/lib/docker.old
sudo service docker start

########## download the container to path /mydata
cd /mydata
sudo docker pull gadget7200/gadget7200:1

####### run the container
sudo docker run -t -i  gadget7200/gadget7200:1  /bin/bash





