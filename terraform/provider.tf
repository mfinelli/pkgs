terraform {
  required_version = "~> 1.1"

  cloud {
    organization = "mfinelli"
    workspaces {
      name = "pkgs"
    }
  }

  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "~> 2.4"
    }
  }
}

provider "vultr" {}
