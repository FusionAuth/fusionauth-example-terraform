terraform {
  required_providers {
    fusionauth = {
      source = "gpsinsight/fusionauth"
      version = "0.1.96"
    }
  }
}

provider "fusionauth" {
  api_key = var.fusionauth_api_key
  host = "https://auth.example.com"
}
