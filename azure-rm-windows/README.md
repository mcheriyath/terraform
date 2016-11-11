# Documentation

The Microsoft Azure provider is used to interact with the many resources supported by Azure.
This one is via ARM API. 

## Pre-requisites

Read this for before creating client_id, client_secret and tenant_id
https://github.com/cloudfoundry-incubator/bosh-azure-cpi-release/blob/master/docs/get-started/create-service-principal.md

- Make sure that your Azure classic resource are migrated properly if you have plans to use them in ARM Mode
Some refereces on how to migrate are given below:
https://blogs.technet.microsoft.com/canitpro/2016/07/05/step-by-step-migrate-your-classic-cloud-services-to-arm/
https://blogs.technet.microsoft.com/canitpro/2016/07/27/step-by-step-migrate-your-classic-cloud-services-to-arm-storage-migration/


## File Lists
create-service-principal.sh - Required to generate and store information like client_id, client_secret and tenant_id as environment variables
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
