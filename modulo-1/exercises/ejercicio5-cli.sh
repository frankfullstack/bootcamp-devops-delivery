#!/bin/bash

set -euo pipefail

# Obtenemos el directorio donde está el script
CURRENT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Comprobamos que se han proporcionado dos parámetros
if [ "$#" -ne 2 ]; then
    echo "Se necesitan únicamente dos parámetros para ejecutar este script"
    exit 1
fi

# Obtenemos la URL y la palabra a buscar
URL="$1"
WORD="$2"

# Definimos el fichero de destino
readonly FILE="$CURRENT_DIR/licencia.txt"

# Comprobamos que los parámetros no están vacíos
if [ -z "$URL" ] || [ -z "$WORD" ]; then
    echo "Error: la URL y la palabra no pueden estar vacías."
    exit 1
fi

# Descargamos el contenido de la página
curl -fLsS "$URL" -o "$FILE"

# Buscamos las coincidencias y controlamos los errores
if MATCHES=$(grep -oiwF -- "$WORD" "$FILE"); then
    COUNT=$(printf '%s\n' "$MATCHES" | wc -l)
    COUNT=$((COUNT))
else
    STATUS=$?

    if [ "$STATUS" -ne 1 ]; then
        echo "Error al buscar la palabra en el fichero." >&2
        exit "$STATUS"
    fi

    COUNT=0
fi

# Comprobamos si se ha encontrado la palabra
if [ "$COUNT" -eq 0 ]; then
    echo "No se ha encontrado la palabra \"$WORD\""
    exit 0
fi

# Obtenemos la primera línea donde aparece
FIRST_LINE=$(grep -inwF -- "$WORD" "$FILE" | sed -n '1{s/:.*//;p;}')

# Mostramos los resultados según el número de apariciones
if [ "$COUNT" -eq 1 ]; then
    echo "La palabra \"$WORD\" aparece 1 vez"
    echo "Aparece únicamente en la línea $FIRST_LINE"
else
    echo "La palabra \"$WORD\" aparece $COUNT veces"
    echo "Aparece por primera vez en la línea $FIRST_LINE"
fi
