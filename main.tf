terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "remote-state"
    storage_account_name = "brenoremotestate"
    container_name       = "remotestate"
    key                  = "pipeline-gitlab-ci/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "remote-state"
    storage_account_name = "brenoremotestate"
    container_name       = "remotestate"
    key                  = "azurevnet/terraform.tfstate"
  }
}


provider "aws" {
  region = "sa-east-1"

  default_tags {
    tags = {
      owner      = "breno"
      managed-by = "terraform"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "breno-remote-state"
    key    = "aws-vpc"
    region = "sa-east-1"
  }
}