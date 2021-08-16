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

## notes

Hostnames are chosen from 
[Paris Métro](https://namingschemes.com/Paris_M%C3%A9tro)
