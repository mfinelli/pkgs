data "vultr_os" "debian_trixie" {
  filter {
    name = "name"
    # curl -H 'Accept: application/json' https://api.vultr.com/v1/os/list
    values = ["Debian 13 x64 (trixie)"]
  }
}

data "vultr_region" "paris" {
  filter {
    name   = "city"
    values = ["Paris"]
  }
}

resource "vultr_ssh_key" "mario" {
  name    = "pkgs"
  ssh_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFk83S5KYE7ErNJW7JEJbTkwTz1WtcNrOCoZ9hMnwBQT mario"
}

resource "vultr_instance" "rome" {
  hostname          = "rome.mfpkg.net"
  label             = "rome.mfpkg.net"
  plan              = "vc2-1c-1gb"
  region            = data.vultr_region.paris.id
  os_id             = data.vultr_os.debian_trixie.id
  firewall_group_id = vultr_firewall_group.firewall.id
  ssh_key_ids       = [vultr_ssh_key.mario.id]
  vpc_ids           = []         # disable private network
  backups           = "disabled" # :(
  enable_ipv6       = true
  activation_email  = true
  ddos_protection   = false
}

resource "vultr_reverse_ipv4" "rome" {
  instance_id = vultr_instance.rome.id
  ip          = vultr_instance.rome.main_ip
  reverse     = vultr_instance.rome.hostname
}

resource "vultr_reverse_ipv6" "rome" {
  instance_id = vultr_instance.rome.id
  ip          = vultr_instance.rome.v6_main_ip
  reverse     = vultr_instance.rome.hostname
}
