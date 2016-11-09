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

Dry/Trial Run
````
time terraform plan -var 'azure_ssh_key_path=$AZURE_SSH_KEY_PATH' -var 'azure_ssh_key_fingerprint=$AZURE_SSH_KEY_FINGERPRINT'
````

Verify the output in the trial run to make sure that the terraform is going to run as expected

Launch
````
time terraform apply -var 'azure_ssh_key_path=$AZURE_SSH_KEY_PATH' -var 'azure_ssh_key_fingerprint=$AZURE_SSH_KEY_FINGERPRINT'
````

## To-Do

Need to do something with the output

## Troubleshooting

Sometimes the -var may not pass the variables as expected. Could always troubleshoot it with replacing it directly with the actual values. Most of the time its a problem incorrectly exported environment variables
