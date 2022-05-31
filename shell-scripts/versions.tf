terraform {
  required_version = ">= 1.1.7"

  required_providers {


    shell = {
      source  = "scottwinkler/shell"
      version = "~> 1.7.10"
    }

  }

  backend "local" {
    path = "tfstate/terraform.tfstate"
  }
}
