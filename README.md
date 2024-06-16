# Terraform

**Introduction** Terraform is an infrastructure orchestration tool used to provision an infrastructure whereas Ansible, cheff, and Putty is a configuration management tools used for installation & configuration-related tasks. Other tools like chef, puppet, and ansible can be used as infrastructure provisioning to a get extent. Terrdaform is based on HCL language , (hashicorp configuration language)

**Installation** windows/linux based platform, remember to include path in Windows to allow terraform command to work, follow https://askubuntu.com/questions/983351/how-to-install-terraform-in-ubuntu

**Provider Declaration**
Define the aws/azure/GCP providers as required & only define here provider version & regions of deployment, For credential of provider for aws use define credential via Environment variable via export AWS_ACCESS KEY & EXPORT SECRET_KEY command 

**Remote backend** THis use to store terraform.tfstate state file as its allow encryption, version controll, locking of tfstate.

#terraform validate  - Command to validate .tf file configuration, The terraform validate command is used to validate the syntax of the terraform files.

#terraform init   - Command to download Provider plugins

#terraform plan   - Command to review the Update in resources, The terraform plan command evaluates a Terraform configuration to determine the desired state of all the resources it declares, then compares that desired state to the real infrastructure objects being managed with the current 
  working directory and workspace.
  
#terraform apply   - command to apply changes to resources on Cloud

#terraform destroy  - command to delete all resources created by terraform file

#terraform destroy -target=<resourcestype.Local resource name>  - i.e if we say Aws instance need deletion #terraform destroy -target aws_instance.myec2
**Terraform Statefile (terraform.tfstate)**  -it maps real-world resources to the existing configuration file, terraform state file also provides information related to the service created.
Terraform the Desired state to the Current state: Terraform primary function is to create, modify and destroy infrastructure resources to match the desired state described in a current terraform configuration. The current state is the actual state of resources that are currently deployed. Terraform tries to ensure that the deployed infrastructure is based on the desired state, if the difference between the two terraform plan presents a description of changes necessary to achieve the desired state. Its important to check as terraform only make desired state to that of the current state only to that parameter which is defined in .tf configuration file, not to that other parameters 

#terraform version  - command to get a version of terraform, provider versions installed.

**Provider Version** - under the provider block you can specify the version of the provider plugin that needs to be installed, you can use different options to define a version. This is also made to avoid automatic updates of the provider version, if still need to upgrade delete the lock.hcl file and modify provider block with the desired version then run #terraform init command.

**Dependency lock(terraform.lock.hcl)** - Terraform dependency lock file allows us to lock to a specific version of the provider.

#terraform init -upgrade  - command overrides the lock.hcl file in place.

**Lifecyle in terraform** Lifecycle is a nested block that can appear within a resource block. The lifecycle block and its contents are meta-arguments, available for all resource blocks regardless of type.

The arguments available within a lifecycle block are create_before_destroy, prevent_destroy, ignore_changes, and replace_triggered_by. 

**Attributes & Output values**: Terraform has the capability to output the attribute of a resource with the output values. An outputted attribute can not only be used for the user reference, but it can also act as an input to the other resources being created via Terraform. 

**Input Variable** : The type argument in a variable block allows you to restrict the type of values that will be accepted as the value for a variable i.e string,list,map,number 

**Count** Count field can be used when there is a need to launch multiple instances of the same type of Resource for example 5 EC2 instances, rather than follow the approach of writing 5 separate resources.tf file 

**count index** : The count index use case involves creating  IAM role resources with different names, count.index  --the distinct index number (starting with 0) corresponding to this instance.

**Conditional Expression**: A conditional expression use the value if a bool expression to select one of the two values.Syntax of conditional expression  Condition ? true_val : false_val

**local value** local value assigns a name to an expression, allowing it to be used multiple times within a module without repeating it.

**Terraform Function** Terraform functions are built-in, reusable code blocks that perform specific tasks within Terraform configurations, such as numeric(min,max) , Date & time , string .




