terraform {
  required_providers {
    genesyscloud = {
      source  = "mypurecloud/genesyscloud"
      version = ">= 1.19.0"
    }
  }
}

provider "genesyscloud" {
  oauthclient_id = var.oauthClientId
  oauthclient_secret = var.oauthClientSecret
  aws_region = var.oauthAWSRegion
  sdk_debug = true
}

resource "genesyscloud_routing_skill" "cxac_example_skill" {
    name = "CXaC_Example_Skill_ARA"
}

