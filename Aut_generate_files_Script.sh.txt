#!/bin/bash
# Directorio donde se almacenarán los archivos generados
TARGET_DIR="/data/FileGateway" # Asegúrate de que este sea el directorio correcto
# Límite de tamaño total en MB
SIZE_LIMIT=3584 # 3.5 GB expresados en MB
# Tamaño inicial de cada archivo en MB
FILE_SIZE=10
# Contador de tamaño total actual
total_size=0
# Inicializar last_file_size
last_file_size=0
# Generar archivos hasta que se alcance el límite de tamaño
while [ $total_size -lt $SIZE_LIMIT ]; do
  # Definir un nombre de archivo aleatorio con extensión .jpg
  filename=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13 ; echo '').jpg
  filepath="$TARGET_DIR/$filename"
    # Generar archivo con un tamaño de FILE_SIZE
  dd if=/dev/urandom of="$filepath" bs=1M count=$FILE_SIZE
  
  # Actualizar el contador del tamaño total
  total_size=$(($total_size + $FILE_SIZE))
  # Opcional: ajustar FILE_SIZE para que no se exceda del tamaño, si es necesario
  if [ $total_size -gt $SIZE_LIMIT ]; then
    last_file_size=$(($SIZE_LIMIT - $total_size + $FILE_SIZE))
    if [ $last_file_size -gt 0 ]; then
      # Crear un archivo más pequeño para completar el tamaño requerido
      filepath="$TARGET_DIR/$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13 ; echo '')-final.jpg"
      dd if=/dev/urandom of="$filepath" bs=1M count=$last_file_size
    fi
    break
  fi
done
echo "Generados $(($total_size - $FILE_SIZE + $last_file_size)) MB de archivos .jpg en $TARGET_DIR"