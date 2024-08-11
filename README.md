# Infrastructure Provisioning For Web 

## Overview

This repository contains the infrastructure provisioning for a web infrastructure stack using Azure. The goal is to provision a complete web infrastructure setup on Azure, including virtual networks, subnets, network security groups, virtual machines, load balancers, application gateways, and an Azure SQL database.

## Deployent
### Clone the project 
```
git clone  https://github.com/azeez-abp/web-infrastrure-with-terraform.git
```

###  Change into web_infra directory
```bash
cd web_infra
```
### Modify main.tf file
- Open main.tf and file locals block, update the variable to your desire value or leave the default values

### Create .example.auto.tfvars file
- Create .example.auto.tfvars file and add the following to the file

```hcl
client_information={
tenant_id = "enter your own tenant id"
subscription_id = "enter your own subcription id"
client_id = "enter your own client id"
client_secret = "enter your own secret"
}

# assign  role to this object to enable it perform the action 

vm_db_login_credentials={
    user1 = "vncomputerosusername" #change this to your own value 
    pass1 = "vmcomputeruserpass" #change this to your own value 
    user = "dbcomputerosusername" #change this to your own value 
    pass = "dbcomputeruserpass" #change this to your own value 
}
# DONT NOT COMMIT THIS FILE IN YOUR REPO
```

### Install terraform and run it commmand 

```hcl
terraform init
terraform plan -var-file='.example.auto.tfvars' -out='resource.tfplan'
terraform apply resource.tfplan
```


# Architecture hit
```
 NSG --> NSG --> ASSOC <-- Subnet --> NIC --> VM <-- Avalability set
 web vm --> loadbalncer
 web vm --> application gateway
``` 