# Terraform

**Introduction** Terraform is an infrastructure orchestration tool used to provision an infrastructure whereas Ansible, cheff, and Putty is a configuration management tools used for installation & configuration-related tasks. Other tools like chef, puppet, and ansible can be used as infrastructure provisioning to a get extent. Terraform is based on HCL language , (hashicorp configuration language)

**Installation** windows/linux based platform, remember to include path in Windows to allow terraform command to work, follow https://askubuntu.com/questions/983351/how-to-install-terraform-in-ubuntu

**Provider Declaration**
Define the aws/azure/GCP providers as required & only define here provider version & regions of deployment, For credential of provider for aws use define credential via Environment variable via export AWS_ACCESS KEY & EXPORT SECRET_KEY command 

**Remote backend** This use to store terraform.tfstate state file as its allow encryption, version control, locking of tfstate.

#terraform validate  - Command to validate .tf file configuration, The terraform validate command is used to validate the syntax of the terraform files.

#terraform init   - Command to download Provider plugins

#terraform plan   - Command to review the Update in resources, The terraform plan command evaluates a Terraform configuration to determine the desired state of all the resources it declares, then compares that desired state to the real infrastructure objects being managed with the current working directory and workspace.
  
#terraform apply  or  #terraform apply -auto-aprrove  - command to apply changes to resources on Cloud

#terraform destroy  - command to delete all resources created by terraform file

#terraform destroy -target <resourcestype.Local resource name>  - i.e if we say Aws instance need deletion #terraform destroy -target aws_instance.myec2

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

**Data Source** VS **Variables** 
Variables are used to parameterize your Terraform configurations. They allow us to define reusable values that can be customized for different environments or deployments. Variables are typically used to make our configurations more flexible and easier to manage by centralizing values that might change based on the context.

Data sources are used to retrieve information from external systems or existing resources and incorporate that information into our configuration. Data sources provide dynamic and context-aware attributes that can be used within our resource definitions. They help us make your configurations more intelligent and adaptable by leveraging information from the real world. https://spacelift.io/blog/terraform-data-sources-how-they-are-utilised 


**Debugging in terraform**   Terraform has detailed logs which can be enabled by setting the TF_LOG environment variable to any value. You can set TF_LOG to one of the log levels TRACE,DEBUG,INFO,WARN or ERROR to change the verbosity of the logs.  TRACE is the most verbose and its is the default if TF_LOG is set to something other than log Level name , To persist logged output you can set TF_LOG_PATH in order to force the log to always be appended to a specific file when logging is enabled.
 #export TF_LOG_PATH=/tmp/crash.log  
 #export TF_LOG=TRACE
 #unset TF_LOG

**Terraform Format**: The terraform fmt command is used to rewrite Terraform configuration files to take care of the overall formatting. 
    #terraform fmt
    
**Tainting Resource /Replace**: The terraform taint command manually marks a Terraform Managed resource as tainted, forcing it to destroy and recreated on the next apply. #terraform taint <resource type>.<name of resource>
  #terraform apply -replace=resourectype.name

**Terraform Plan file**:  The generated terraform plan can be saved to a specific path. This plan can then be used with terraform apply to be certain that only the changes shown in this plan are applied. Example :   #terraform plan -out=path  , #terraform apply demopath

**Terraform output**: command is used to extract the value of output variable from the state file. #terraform output

**Dealing with Large Configuration**   The -target=resource flag can be used to target a specific resource. Generally used as a means to operate on isolated portions of very large configurations.Setting Refresh along with Target flags #terraform plan -refresh=false -target=<resources type.Local resource name> 

**Updating an existing resource created by Terraform** If we updating an new feilds like addition of tag then when you do terraform apply to make changes , But if you making changes to parameters like ami for this resource need to be deleted & recreated when did terraform apply 
 https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-change   & https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-change

**Terraform import** - import resources which are manually created #terraform import resourcetype.name <instanceiddetails or name>

**terraform refresh - if someone manual made an change in outside terraform & want to update statefile to include that changes**

**terraform state rm <resource_type>.<resource_name>    If you want to remove a resource from the Terraform state without deleting the actual resource**

**Terraform Modules** 
The Root Module
Every Terraform configuration has at least one module, known as its root module, which consists of the resources defined in the .tf files in the main working directory.

Child Modules
A Terraform module (usually the root module of a configuration) can call other modules to include their resources into the configuration. A module that has been called by another module is often referred to as a child module.

Child modules can be called multiple times within the same configuration, and multiple configurations can use the same child module.

Published Modules
In addition to modules from the local filesystem, Terraform can load modules from a public or private registry. This makes it possible to publish modules for others to use, and to use modules that others have published.

**Terraform workspace**
Terraform allows us to have multiple workspaces, each workspace have different state file but using same configuration files , its use to multiple environment like staging , Production , Dev 
                #terraform workspace -h   (it will give a list of all commands related to workspace)
                #terraform workspace show
                #terraform workspace new <workspacename>
                #terraform workspace list
                #terraform workspace select <workspacename>

**Deployment of same resource in different region** in that case under provider block we different provider with alias name & resource block has defined with provider with specific alias name of provider 

**securing secrets in Code**  
Method 1 : Defining variable.tf file with sensitive field as True 

Method 2: Create secret.tfvars file that also hold secret username & passwords & pass them during terraform apply command 
  # terraform apply -var-file="secret.tfvars"

using above methods help to secure password to be display when run terraform apply command 

Method 3 : Passing secret as environment variable 
When Terraform runs, it looks in your environment for variables that match the pattern TF_VAR_<VARIABLE_NAME>, and assigns those values to the corresponding Terraform variables in your configuration.

#export TF_VAR_db_username=
#export TF_VAR_db_password=

Mthod 4 follow Hashicorp vault https://github.com/iam-veeramalla/terraform-zero-to-hero/tree/main/Day-7

**Sentinel Policies**

**Depand on** Terraform depends_on allows you to create an explicit dependency between two resources.

**Provisioner in Terraform** https://spacelift.io/blog/terraform-provisioners 
Local-exec provisioners   -- executed on local terraform host i.e for taking private ip of ec2 on file 
Remote-exec provisioners  -- executed on resource this also need connection block 
File provisioners   --- executed on resource this also need connection block  copy a file to resource 




                
