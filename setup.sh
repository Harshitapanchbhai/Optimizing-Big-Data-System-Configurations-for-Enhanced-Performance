sudo apt-get update
sudo apt-get install -y --no-install-recommends python2.7 ssh   
sudo apt-get install -y python-pip wget
sudo pip install --upgrade pip virtualenv
sudo apt-get install -y --no-install-recommends openjdk-8-jdk-headless
sudo apt-get install -y --no-install-recommends git vim nano ranger
sudo apt-get install -y --no-install-recommends maven net-tools inetutils-ping
sudo apt-get install -y --no-install-recommends bc openssh-client
sudo apt-get install -y --no-install-recommends openssh-server wget
sudo apt-get install -y --no-install-recommends build-essential     

wget https://archive.apache.org/dist/hadoop/common/hadoop-3.3.5/hadoop-3.3.5.tar.gz
git clone https://github.com/Intel-bigdata/HiBench.git

cp  hadoop-3.3.5.tar.gz ~/
cd ~
tar -xf hadoop-3.3.5.tar.gz
rm  hadoop-3.3.5.tar.gz

ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

ls -lrt .ssh/

