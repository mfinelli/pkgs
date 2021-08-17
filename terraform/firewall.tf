resource "vultr_firewall_group" "firewall" {
  description = "pkgs.finelli.dev"
}

resource "vultr_firewall_rule" "ssh_v4" {
  firewall_group_id = vultr_firewall_group.firewall.id
  protocol          = "tcp"
  ip_type           = "v4"
  subnet            = "0.0.0.0"
  subnet_size       = 0
  port              = "22"
  notes             = "allow ssh (v4)"
}

resource "vultr_firewall_rule" "ssh_v6" {
  firewall_group_id = vultr_firewall_group.firewall.id
  protocol          = "tcp"
  ip_type           = "v6"
  subnet            = "::"
  subnet_size       = 0
  port              = "22"
  notes             = "allow ssh (v6)"
}

resource "vultr_firewall_rule" "https_v4" {
  firewall_group_id = vultr_firewall_group.firewall.id
  protocol          = "tcp"
  ip_type           = "v4"
  subnet            = "0.0.0.0"
  subnet_size       = 0
  port              = "443"
  notes             = "allow cloudflare (v4)"
  source            = "cloudflare"
}

resource "vultr_firewall_rule" "https_v6" {
  firewall_group_id = vultr_firewall_group.firewall.id
  protocol          = "tcp"
  ip_type           = "v6"
  subnet            = "::"
  subnet_size       = 0
  port              = "443"
  notes             = "allow cloudflare (v6)"
  source            = "cloudflare"
}
