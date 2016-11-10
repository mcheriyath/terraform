# Documentation

## Core TF File Lists
provider.tf - Mentions the subscription details which is fetch with Azure Classic mode
vars.tf - Variables defined within main.tf and passed while running terraform apply command
main.tf - Main file defining resources to be created and attached to the instance being launched

## SSH key for Azure Instance

generate-ssh.sh - File which converts an existing id_rsa file to Azure format and generates its fingerprint, then export to environment variables to be later used for terraform -var

##Usage 
````
source ./generate-ssh.sh
````

##Run Terraform

Get an Idea of how stuff works with the following command
````
terraform graph | dot -Tpng > graph.png
````
![Image](/azure-classic-linux/graph.png?raw=true "Terraform Graph")


Dry/Trial Run
````
time terraform plan -var 'azure_ssh_key_path=$AZURE_SSH_KEY_PATH' -var 'azure_ssh_key_fingerprint=$AZURE_SSH_KEY_FINGERPRINT'
````

Verify the output in the trial run to make sure that the terraform is going to run as expected

Launch
````
time terraform apply -var 'azure_ssh_key_path=$AZURE_SSH_KEY_PATH' -var 'azure_ssh_key_fingerprint=$AZURE_SSH_KEY_FINGERPRINT'
````

Destroy
````
time terraform destroy -var 'azure_ssh_key_path=$AZURE_SSH_KEY_PATH' -var 'azure_ssh_key_fingerprint=$AZURE_SSH_KEY_FINGERPRINT'
````

## To-Do

Need to do something with the output

## Troubleshooting

- Sometimes the -var may not pass the variables as expected. Could always troubleshoot it with replacing it directly with the actual values. Most of the time its a problem incorrectly exported environment variables
- While destroying the infrastructure sometimes it throws an error towards the end like:
````
* azure_virtual_network.vnet: Error waiting for Virtual Network name-network to be deleted: Error response from Azure. Code: BadRequest, Message: Cannot delete or modify virtual network while in use 'nameof-network'.

Terraform does not automatically rollback in the face of errors.
Instead, your Terraform state file has been partially updated with
any resources that successfully completed. Please address the error
above and apply again to incrementally change your infrastructure.
````
This is because it takes a little time for Azure release all the dependencies running. We are good to re-run the same destroy command after a few minutes or even seconds to completely destroy all the resources we launched.

