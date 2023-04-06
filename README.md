# Nebula-kvm

## Installation Vagrantfile

```bash
vagrant up --no-provision
vagrant provision panel
vagrant provision kvm-1 kvm-2
```

## Post installation Vagrantfile

Après avoir l'accès à l'interface admin sur l'IP :
- http://192.168.50.10:9869/
- user : oneadmin
- mdp : !Passe123?

Il faut rajouter les 2 hôtes pour faire le cluster :

