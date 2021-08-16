# ansible

Configuration for the server backing https://pkgs.finelli.dev.

```shell
ansible-galaxy install -r requirements.yml
```

```shell
ansible-playbook -i hosts site.yml
```

## bootstrap

```shell
ansible-playbook -i hosts bootstrap.yml
```

## vault

To create the secret:

```shell
pwgen -cnsy 128 1 | gpg -ear 36FDA306 > vault.asc
```

To encrypt a file:

```shell
./vault ./path/to/file
```

## notes

Hostnames are chosen from
[Paris Métro](https://namingschemes.com/Paris_M%C3%A9tro)
