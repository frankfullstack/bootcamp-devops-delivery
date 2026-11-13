#!/bin/bash

set -euo pipefail

# Obtenemos el directorio donde está el script
CURRENT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Comprobamos si ya existe la ruta foo
if [ -e "$CURRENT_DIR/foo" ]; then
    echo "La ruta foo ya existe. No se realizará ningún cambio."
    exit 0
fi

# Creamos los directorios necesarios
mkdir -p "$CURRENT_DIR/foo/"{dummy,empty}

# Creamos los ficheros
touch "$CURRENT_DIR/foo/dummy/"file{1,2}.txt

# Escribimos contenido en file1.txt
echo 'Me encanta la bash!!' > "$CURRENT_DIR/foo/dummy/file1.txt"

echo "Estructura creada correctamente."
