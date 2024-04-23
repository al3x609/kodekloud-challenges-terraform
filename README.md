


# plan
terraform plan -var-file variables.tfvars  -out plan
#
terraform apply plan

# ver el estado de la plataforma
terraform show

#
# describir instancias
aws ec2 --endpoint-url http://aws:4566  describe-instances

#consultar estado instancia por ID
aws ec2 --endpoint-url http://aws:4566  describe-instance-status --instance-ids  [EC2_INSTANCE_ID]