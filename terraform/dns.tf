resource "vultr_dns_domain" "mfpkgnet" {
  domain = "mfpkg.net"
}

resource "vultr_dns_record" "caa" {
  domain = vultr_dns_domain.mfpkgnet.id
  name   = ""
  data   = "0 issue \";\""
  type   = "CAA"
}

resource "vultr_dns_record" "spf" {
  domain = vultr_dns_domain.mfpkgnet.id
  name   = ""
  data   = "\"v=spf1 -all\""
  type   = "TXT"
}

resource "vultr_dns_record" "dmarc" {
  domain = vultr_dns_domain.mfpkgnet.id
  name   = "_dmarc"
  data   = "\"v=DMARC1; p=reject\""
  type   = "TXT"
}

