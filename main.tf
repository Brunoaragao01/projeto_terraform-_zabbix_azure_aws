terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.61.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.112.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"                    # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "brunovpterraformstate"                 # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "remote-state"                          # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "zabbix-server-agent/terraform.tfstate" # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}

provider "azurerm" {
  features {}
}

provider "aws" {

  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "Bruno_Aragao"
      managed-by = "terraform"
    }
  }

}

data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-terraform-state"    # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "brunovpterraformstate" # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "remote-state"
    key                  = "azure-vnet/terraform.tfstate"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "brunoaragao-remote-state"
    key    = "aws-vpc/terraform.tfstate"
    region = "us-east-1"
  }
}


