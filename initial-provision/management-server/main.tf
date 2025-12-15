resource "proxmox_virtual_environment_download_file" "debian_cloud_image" {
  content_type = "import"
  datastore_id = "Unraid"
  node_name    = "proxmox-ve"
  url          = "https://cloud.debian.org/images/cloud/trixie/20251117-2299/debian-13-genericcloud-amd64-20251117-2299.qcow2"
  # need to rename the file to *.qcow2 to indicate the actual file format for import
  file_name = "trixie-cloudimg-amd64.qcow2"
}

resource "proxmox_virtual_environment_vm" "test_vm" {
  name      = "test-terraform"
  node_name = "proxmox-ve"

  # should be true if qemu agent is not installed / enabled on the VM
  stop_on_destroy = true

  initialization {
    user_account {
      # do not use this in production, configure your own ssh key instead!
      username = "steven"
      
    }
  }

  disk {
    datastore_id = "local-lvm"
    import_from  = proxmox_virtual_environment_download_file.debian_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 30
  }
}