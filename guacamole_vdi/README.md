## Installation de Guacamole

Pour l'installation de Guacamole il faut récupérer les dockerfiles et les déployer :

```bash
apt install docker.io
```
```bash
docker run --name guacd -d guacamole/guacd
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgres > script/initdb.sql
docker run --name guac-postgres -e POSTGRES_PASSWORD=guacamole_password -e POSTGRES_DB=guacamole_db -e POSTGRES_USER=guacamole_user -v $PWD/script:/docker-entrypoint-initdb.d -d postgres:9.6.23
docker run --name guac-postgres -e POSTGRES_PASSWORD=guacamole_password -e POSTGRES_DB=guacamole_db -e POSTGRES_USER=guacamole_user -v $PWD/script:/docker-entrypoint-initdb.d -d postgres:9.6.23
```

## Installation des hooks pour OpenNebula

Les hooks vont permettre à OpenNebula de faire des actions données, ici si une VM est créée avec un tag **GUAC_GROUP = 1** alors le docker Guacamole va mettre la VM dans un groupe qui sera attribué à un utilisateur pour la VDI.

Avant ça il faut installer les modules python :
```bash
pip install guacapy pyone
```

On crée le fichier ***add_guac_conn.hook*** :

```
NAME = add-guac-conn
TYPE = state
COMMAND = guacamole/add_conn.py
ARGUMENTS = $TEMPLATE
ON = CUSTOM
RESOURCE = VM
STATE = ACTIVE
LCM_STATE = RUNNING
```

Et le fichier ***del_guac_conn.hook*** :
```
NAME = del-guac-conn
TYPE = state
COMMAND = guacamole/del_conn.py
ARGUMENTS = $TEMPLATE
ON = CUSTOM
RESOURCE = VM
STATE = POWEROFF
LCM_STATE = LCM_INIT
```

Puis on ajoute les 2 hooks à OpenNebula :
```bash
onehook create add_guac_conn.hook
onehook create del_guac_conn.hook
```

Ensuite il faut mettre les fichiers add_conn.py & del_conn.py contenu dans le repo du Github dans ***/var/lib/one/remotes/hooks/guacamole/***

```
mkdir -p /var/lib/one/remotes/hooks
chmod +x add_conn.py
chmod +x del_conn.py
```

