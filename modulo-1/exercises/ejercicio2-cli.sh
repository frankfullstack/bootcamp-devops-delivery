#!/bin/bash

set -euo pipefail

# Obtenemos el directorio donde está el script
CURRENT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Definimos las rutas de los ficheros
SOURCE="$CURRENT_DIR/foo/dummy/file1.txt"
TARGET="$CURRENT_DIR/foo/dummy/file2.txt"
DESTINATION="$CURRENT_DIR/foo/empty/file2.txt"

# Comprobamos si el ejercicio ya se ha realizado
if [ -e "$DESTINATION" ]; then
    echo "file2.txt ya existe en empty/. No se realizará ningún cambio."
    exit 0
fi

# Comprobamos que existen los archivos y directorios necesarios
if [ ! -f "$SOURCE" ] || [ ! -f "$TARGET" ] || [ ! -d "$CURRENT_DIR/foo/empty" ]; then
    echo "Error: falta algún archivo o directorio del ejercicio 1."
    exit 1
fi

# Copiamos el contenido de file1.txt a file2.txt
cat "$SOURCE" > "$TARGET"

# Movemos file2.txt a la carpeta empty
mv "$TARGET" "$DESTINATION"

echo "Ejercicio 2 completado correctamente."
