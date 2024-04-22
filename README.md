
#README.md
0. pre requisitos Ansible

apt update
apt -y install python3-pip
python3 -m pip install  ansible==4.10.0

ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N "" -q
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
export PATH=~/.local/bin:$PATH

1. optional: install terraform MANUAL mode

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt install terraform=1.1.5

2. crear archivos terraform

3. comandos
terraform init
terraform plan -out plan
terraform apply
terraform destroy

