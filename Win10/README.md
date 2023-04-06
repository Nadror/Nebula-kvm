## Template Windows 10 Open-Nebula


### Prérequis

Désactivation de apparmor / ufw sous Ubuntu... 

```bash
sudo systemctl disable apparmor
sudo ufw disable
```
### Récupération des pilotes / création du template Windows

Tout d'abord il faut récupérer une ISO de Windows 10 ainsi que les pilotes VirtIO permettant l'installation des cartes réseaux, pilotes graphiques etc...

Pour ça on directement les récupérer via la commande ***wget*** dans le ***/var/tmp*** :

```bash 
wget -O /var/tmp/virtio-win.iso https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso
wget -O /var/tmp/one-context-5.10.0.iso https://github.com/OpenNebula/addon-context-windows/releases/download/v5.10.0/one-context-5.10.0.iso
wget -O /var/tmp/win10.iso https://kdrive.infomaniak.com/2/app/199404/share/03d76228-4454-493d-aff0-a5d51e3c694f/files/17/download
```
Ensuite on les déclares dans le datastore pas défaut pour les "images" :

```bash
oneimage create -d 1 --name "Windows 10 ISO" --path /var/tmp/win10.iso --type CDROM
oneimage create -d 1 --name "Virtio Windows Drivers ISO" --path /var/tmp/virtio-win.iso --type CDROM
oneimage create -d 1 --name "ONE Windows Context ISO" --path /var/tmp/virtio-win.iso --type CDROM
```

Puis on crée un disque libre persistent pour l'installation de Windows 10 :
```bash
oneimage create -d 1 --name "Windows 10" --type OS --size 14G --persistent
```

Il suffit maintenant de créer la template pour déployer Windows 10 :

```yaml
AS_UID = "0"
CONTEXT = [
  GUAC_GROUP = "1",
  NETWORK = "YES",
  SSH_PUBLIC_KEY = "$USER[SSH_PUBLIC_KEY]" ]
CPU = "2"
DISK = [
  DEV_PREFIX = "vd",
  IMAGE = "Windows 10",
  IMAGE_UNAME = "oneadmin" ]
DISK = [
  IMAGE = "virtio",
  IMAGE_UNAME = "oneadmin" ]
DISK = [
  IMAGE = "One context ISO",
  IMAGE_UNAME = "oneadmin" ]
DISK = [
  IMAGE = "disk windows 10",
  IMAGE_UNAME = "oneadmin" ]
GRAPHICS = [
  LISTEN = "0.0.0.0",
  TYPE = "VNC" ]
HOT_RESIZE = [
  CPU_HOT_ADD_ENABLED = "NO",
  MEMORY_HOT_ADD_ENABLED = "NO" ]
HYPERVISOR = "kvm"
INPUT = [
  BUS = "usb",
  TYPE = "tablet" ]
MEMORY = "2048"
MEMORY_RESIZE_MODE = "BALLOONING"
MEMORY_UNIT_COST = "MB"
NIC = [
  NETWORK = "host-only",
  NETWORK_UNAME = "oneadmin",
  RDP = "YES",
  SECURITY_GROUPS = "0" ]
NIC = [
  NETWORK = "Int",
  NETWORK_UNAME = "oneadmin",
  RDP = "YES",
  SECURITY_GROUPS = "0" ]
OS = [
  BOOT = "disk0",
  FIRMWARE = "",
  FIRMWARE_SECURE = "YES" ]
VCPU = "4"
```
> A changer en fonction de chaque config (CPU, NIC, disques...)


