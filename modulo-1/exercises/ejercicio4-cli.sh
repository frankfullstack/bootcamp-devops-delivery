#!/bin/bash

set -euo pipefail

# Obtenemos el directorio donde está el script
CURRENT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Definimos las constantes
readonly URL="https://www.gnu.org/licenses/gpl-3.0.txt"
readonly FILE="$CURRENT_DIR/licencia.txt"

# Obtenemos la palabra a buscar
WORD="${1:-}"

# Comprobamos que se ha proporcionado una palabra
if [ -z "$WORD" ]; then
    echo "Error: debes proporcionar una palabra."
    exit 1
fi

# Descargamos el contenido de la página
curl -fLsS "$URL" -o "$FILE"

# Contamos las apariciones de la palabra
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

# Mostramos los resultados
echo "La palabra \"$WORD\" aparece $COUNT veces"
echo "Aparece por primera vez en la línea $FIRST_LINE"
