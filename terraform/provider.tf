terraform {
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "~> 2.28"
    }
  }
}

provider "vultr" {}
