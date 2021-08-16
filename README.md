# pkgs

Infracode and PKGBUILDS for https://pkgs.finelli.dev.

## how to use

First you need to add my GPG key to your pacman keyring and sign it locally:

```shell
curl -s https://finelli.pub/36FDA306.asc | sudo pacman-key -a -
sudo pacman-key --lsign-key C3CD75B002978A8468CA7B1F6C3ADDDE36FDA306
```

Then add the following repository configuration to your `pacman.conf`:

```ini
[supermario]
Server = https://pkgs.finelli.dev/arch/$arch
```
