## Terraform configuration

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "mflyyou"
    workspaces {
      prefix = "learn-state-migration_"
    }
  }
  #  backend "local" {
  #    path = "terraform.tfstate"
  #  }

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }
  }
  required_version = ">= 1.1.7"

}

variable "name_length" {
  description = "The number of words in the pet name"
  default     = "3"
}

resource "random_pet" "pet_name2" {
  length    = var.name_length
  separator = "-"
}


output "pet_name2" {
  value = random_pet.pet_name2.id
}