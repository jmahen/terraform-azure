# https://learn.hashicorp.com/tutorials/terraform/azure-build

Here are the commands used

Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi

az login

az account list

az account set --subscription "<Subscription ID>"

#Service Principal

az ad sp create-for-rbac -n tfadminc91826c0 --role="Contributor" --scopes="/subscriptions/<Subscription ID>"

# Set ENV Values for Azure Authentication

$Env:ARM_CLIENT_ID = ""
$Env:ARM_CLIENT_SECRET = ""
$Env:ARM_SUBSCRIPTION_ID = ""
$Env:ARM_TENANT_ID = ""
$Env:ARM_ACCESS_KEY = ""  # Storage AC Key

# ------------------------------------------------

New-Item -Path "." -Name "learn-terraform-azure" -ItemType "directory"

CD learn-terraform-azure

Create main.tf

terraform init

terraform fmt

terraform validate

terraform plan

terraform apply

terraform apply -auto-approve

terraform apply -var-file prd-vaiables.tfvars -auto-approve 

terraform apply -replace="azurerm_virtual_network.vnet2"

terraform show

terraform state list

terraform destroy

terraform import azurerm_windows_web_app.mjtfdemoapp /subscriptions/<Subscription ID>/resourceGroups/terraform-rg/providers/Microsoft.Web/sites/mjtfdemoapp

terraform import azurerm_service_plan.app_plan /subscriptions/<Subscription ID>/resourceGroups/terraform-rg/providers/Microsoft.Web/serverfarms/app-service-plan-free

terraform init -reconfigure

terraform init -migrate-state

# Any chnage in backend requires terraform init



