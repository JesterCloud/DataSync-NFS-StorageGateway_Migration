#!/bin/bash
# Instalar servidor NFS
yum install -y nfs-utils

# Crear el directorio que se compartirá
mkdir /var/nfs
chown nfsnobody:nfsnobody /var/nfs
chmod 755 /var/nfs

# Configurar exportaciones NFS
echo "/var/nfs *(rw,sync,no_subtree_check,no_root_squash)" > /etc/exports

# Iniciar servicios NFS y exportar directorios compartidos
systemctl enable nfs-server
systemctl start nfs-server
exportfs -ra