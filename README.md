# Nebula-kvm

## Installation Vagrantfile

```bash
vagrant up --no-provision
vagrant provision panel
vagrant provision kvm-1 kvm-2
```

## Post installation Vagrantfile

### Ajout des hôtes au cluster
Après avoir l'accès à l'interface admin sur l'IP :
- http://192.168.50.10:9869/
- user : oneadmin
- mdp : !Passe123?

Il faut rajouter les 2 hôtes pour faire le cluster :

![](https://i.imgur.com/dI0M0CN.png)

### Configuration des interfaces NIC

#### Installation d'un bridge simple
![](https://i.imgur.com/b1JkoyD.png)
#### Création du subnet
![](https://i.imgur.com/Gl9Safz.png)
#### Ajout du DNS + passerelle pour Internet
![](https://i.imgur.com/rjXXHaS.png)

Lorsque cette interface sera associée à une VM, elle aura Internet via l'interface de sortie crée par le vagrantfile sur l'interface du panel

### Installation de OneFlow 

OneFlow va nous permettre de crée une série de VM automatiquement via un "Service", il n'est pas activé par défaut, on va donc l'installer : 

```bash
apt install libxmlrpc-c++8-dev
systemctl enable opennebula-flow
systemctl start opennebula-flow
```


### Enlever l'erreur pour FireEdge
Lor de l'installation par défaut, OpenNebula nous dit qu'il y a un problème pour "Public FireEdge" on va donc le désactiver par défaut sur l'interface publique en commentant cette ligne dans le fichier **/etc/one/sunstone-server.conf**
![](https://i.imgur.com/ZKGttYm.png)

Il suffit maintenant de redémarrer fireedge : 
```bash
systemctl restart opennebula-fireedge
```
rt