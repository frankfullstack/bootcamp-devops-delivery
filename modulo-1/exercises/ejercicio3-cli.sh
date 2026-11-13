#!/bin/bash

set -euo pipefail

# Obtenemos el directorio donde está el script
CURRENT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Definimos las rutas de los ficheros
SOURCE="$CURRENT_DIR/foo/dummy/file1.txt"
TARGET="$CURRENT_DIR/foo/dummy/file2.txt"
DESTINATION="$CURRENT_DIR/foo/empty/file2.txt"

# Obtenemos el argumento o utilizamos el texto por defecto
FILE1_TEXT="${1:-Que me gusta la bash!!!!}"

# Eliminamos la estructura anterior si existe (haciendolo idempotente)
# No usar este approach si ya existe riesgo de que haya algo en ese directorio
if [ -d "$CURRENT_DIR/foo" ]; then
    rm -rf -- "$CURRENT_DIR/foo"
fi

# Comprobamos si ya existe la ruta foo
if [ -e "$CURRENT_DIR/foo" ]; then
    echo "La ruta foo ya existe. No se realizará ningún cambio."
    exit 0
fi

# Creamos los directorios necesarios
mkdir -p "$CURRENT_DIR/foo/"{dummy,empty}

# Creamos los ficheros
touch "$SOURCE" "$TARGET"

# Escribimos el contenido en file1.txt
printf '%s\n' "$FILE1_TEXT" > "$SOURCE"

printf 'Estructura inicial creada correctamente.\n\n'

# Copiamos el contenido de file1.txt a file2.txt
cat "$SOURCE" > "$TARGET"

# Movemos file2.txt a la carpeta empty
mv "$TARGET" "$DESTINATION"

echo "Ejercicio 3 completado correctamente."
