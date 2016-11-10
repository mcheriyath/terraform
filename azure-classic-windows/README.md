# Documentation

## Core TF File Lists
provider.tf - Mentions the subscription details which is fetch with Azure Classic mode
vars.tf - Variables defined within main.tf and passed while running terraform apply command
main.tf - Main file defining resources to be created and attached to the instance being launched
output.tf - Fetches the Public IP address of the recently launched Instance and displays while we run tf apply

##Run Terraform

Dry/Trial Run
````
time terraform plan
````

Verify the output in the trial run to make sure that the terraform is going to run as expected

Launch
````
time terraform apply 
````

Destroy
````
time terraform destroy
````

## To Do
- Launch a Windows Instance from the Image imported from datacenter

## Troubleshooting
 - None for now.
