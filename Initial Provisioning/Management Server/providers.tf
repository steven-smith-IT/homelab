terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.89.0"
    }
  }
}

provider "proxmox" {
  endpoint = "https://proxmox.home:8006/"

  # TODO: use terraform variable or remove the line, and use PROXMOX_VE_USERNAME environment variable
  # TODO: use terraform variable or remove the line, and use PROXMOX_VE_PASSWORD environment variable

  # because self-signed TLS certificate is in use
  insecure = true

  ssh {
    agent = true
  }
}