# Terraform

**Introduction** Terraform is an infrastructure orchestration tool used to provision an infrastructure whereas Ansible, cheff, and Putty is a configuration management tools used for installation & configuration-related tasks. Other tools like chef, puppet, and ansible can be used as infrastructure provisioning to a get extent.

**Installation** windows/linux based platform, remember to include path in Windows to allow terraform command to work, follow https://askubuntu.com/questions/983351/how-to-install-terraform-in-ubuntu

**Provider Declaration**
Define the aws/azure/GCP providers as required & only define here provider version & regions of deployment, For credential of provider for aws use define credential via Environment variable via export AWS_ACCESS KEY & EXPORT SECRET_KEY command 

**Remote backend** THis use to store terraform.tfstate state file as its allow encryption, version controll, locking of tfstate.
