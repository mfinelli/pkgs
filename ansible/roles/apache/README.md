# apache

Installs and configures apache to serve static files.

## ssl

We use an origin certificate from Cloudflare. For now it is provisioned
manually via the console:

```
Generate private key and CSR with Cloudflare
Private key type: ECC
Hostnames: pkgs.finelli.dev
Certificate Validity: 15 years
```
