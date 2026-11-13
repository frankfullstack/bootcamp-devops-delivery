# Bootcamp-devops-delivery
Lemoncode Bootcamp Devops Delivery

## Módulo 1 · Bash y línea de comandos

Ejercicios del **Bootcamp DevOps Delivery de Lemoncode**. Este módulo practica creación y manipulación de archivos y directorios, argumentos de scripts, descarga de recursos con `curl` y búsquedas con `grep`.

### Requisitos

- **Bash** y utilidades habituales de terminal (`mkdir`, `touch`, `cat`, `mv`, `grep`, `sed`, `wc`, `curl`).
- Conexión a Internet para las pruebas que descargan la licencia GNU GPL (ejercicios 4 y 5).
- Ejecutar los comandos de esta guía **desde el directorio `modulo-1/`**, donde se encuentra este README.

Los scripts se pueden ejecutar con `bash`, sin necesidad de conceder permisos de ejecución:

```bash
bash exercises/ejercicio1-cli.sh
```

Si prefieres ejecutarlos con `./`, primero concede permisos:

```bash
chmod +x exercises/ejercicio{1,2,3,4,5}-cli.sh
```

> **Importante:** los ejercicios 1, 2 y 3 trabajan sobre la misma carpeta `exercises/foo/`. Sigue el orden de las pruebas y conserva una copia de cualquier archivo que quieras guardar. El ejercicio 3 **elimina y recrea** esa carpeta.

### Ejercicio 1 · Crear una estructura de directorios

Crea `foo/dummy/` y `foo/empty/`, con `file1.txt` y `file2.txt` dentro de `dummy/`. El primero contiene `Me encanta la bash!!` y el segundo está vacío.

El ZIP del módulo ya incluye una carpeta `foo/` como resultado de otros ejercicios. **Solo si quieres probar el ejercicio 1 desde cero**, y después de asegurarte de que no contiene nada que necesites, elimínala:

```bash
rm -r exercises/foo
bash exercises/ejercicio1-cli.sh
```

Comprueba la estructura y los contenidos:

```bash
find exercises/foo -print
cat exercises/foo/dummy/file1.txt
wc -c < exercises/foo/dummy/file2.txt
```

Estructura esperada (el orden de `find` puede variar):

```text
foo/
├── dummy/
│   ├── file1.txt
│   └── file2.txt
└── empty/
```

`cat` debe mostrar `Me encanta la bash!!` y `wc -c` debe devolver `0`.

**Prueba de repetición:** vuelve a ejecutar `bash exercises/ejercicio1-cli.sh`. Si `foo/` ya existe, el script informa de ello y no modifica su contenido.

### Ejercicio 2 · Copiar contenido y mover un archivo

**Requisito previo:** haber ejecutado el ejercicio 1 para que `exercises/foo/dummy/file2.txt` exista. Si sigues la guía en orden, no necesitas preparar nada más.

```bash
bash exercises/ejercicio2-cli.sh
```

Comprueba que `file2.txt` se haya movido y que ambos archivos tengan el mismo contenido:

```bash
find exercises/foo -print
cat exercises/foo/dummy/file1.txt
cat exercises/foo/empty/file2.txt
cmp exercises/foo/dummy/file1.txt exercises/foo/empty/file2.txt
```

Estructura esperada:

```text
foo/
├── dummy/
│   └── file1.txt
└── empty/
    └── file2.txt
```

Los dos `cat` deben mostrar `Me encanta la bash!!`. `cmp` no muestra salida si los archivos son idénticos y termina correctamente.

**Prueba de repetición:** al ejecutar el script de nuevo, detecta que `file2.txt` ya está en `empty/` y no realiza cambios.

### Ejercicio 3 · Unificar los pasos y recibir un texto

Este ejercicio es **autocontenido**: vuelve a crear la estructura del ejercicio 1, escribe el texto indicado y realiza el movimiento del ejercicio 2. **Atención: antes de hacerlo borra `exercises/foo/` y todo su contenido.**

Prueba con un texto personalizado:

```bash
bash exercises/ejercicio3-cli.sh "Estoy aprendiendo DevOps"
cat exercises/foo/dummy/file1.txt
cat exercises/foo/empty/file2.txt
```

Ambos archivos deben contener:

```text
Estoy aprendiendo DevOps
```

Prueba sin argumento (o con un argumento vacío):

```bash
bash exercises/ejercicio3-cli.sh
# Equivalente para el valor por defecto:
bash exercises/ejercicio3-cli.sh ""
```

En ambos casos, el contenido final de los archivos debe ser:

```text
Que me gusta la bash!!!!
```

Comprueba la estructura final:

```bash
find exercises/foo -print
cmp exercises/foo/dummy/file1.txt exercises/foo/empty/file2.txt
```

La estructura será la misma que al finalizar el ejercicio 2. Cada ejecución reconstruye `foo/`, por lo que no conserva archivos adicionales que hubiera dentro.

### Ejercicio 4 · Descargar una web y buscar una palabra

Descarga el texto de la licencia GNU GPL v3 desde una URL **fija** (`https://www.gnu.org/licenses/gpl-3.0.txt`), lo guarda en `exercises/licencia.txt` y busca la palabra recibida como argumento. La búsqueda no distingue mayúsculas/minúsculas y considera palabras completas.

Prueba con una palabra que aparece en la licencia:

```bash
bash exercises/ejercicio4-cli.sh software
```

El resultado indica el número de apariciones y la primera línea, por ejemplo con este **formato** (los números dependen del fichero descargado):

```text
La palabra "software" aparece N veces
Aparece por primera vez en la línea L
```

Prueba con una palabra que previsiblemente no aparece:

```bash
bash exercises/ejercicio4-cli.sh ornitorrinco
```

Resultado esperado:

```text
No se ha encontrado la palabra "ornitorrinco"
```

Comprueba la validación del argumento obligatorio:

```bash
bash exercises/ejercicio4-cli.sh
```

Resultado esperado (el script devuelve código de salida `1`):

```text
Error: debes proporcionar una palabra.
```

Puedes inspeccionar la descarga con `head -n 5 exercises/licencia.txt`.

### Ejercicio 5 · URL y palabra como parámetros (opcional)

Amplía el ejercicio 4 para recibir **exactamente dos argumentos**: primero la URL y después la palabra. También distingue las búsquedas con cero, una o varias apariciones. Guarda el contenido descargado en `exercises/licencia.txt`.

**Caso A · Número de parámetros incorrecto:**

```bash
bash exercises/ejercicio5-cli.sh https://www.gnu.org/licenses/gpl-3.0.txt software extra
```

Resultado esperado (código de salida `1`):

```text
Se necesitan únicamente dos parámetros para ejecutar este script
```

**Caso B · Sin coincidencias:**

```bash
bash exercises/ejercicio5-cli.sh https://www.gnu.org/licenses/gpl-3.0.txt ornitorrinco
```

Resultado esperado:

```text
No se ha encontrado la palabra "ornitorrinco"
```

**Caso C · Varias coincidencias:**

```bash
bash exercises/ejercicio5-cli.sh https://www.gnu.org/licenses/gpl-3.0.txt software
```

El resultado tiene este formato:

```text
La palabra "software" aparece N veces
Aparece por primera vez en la línea L
```

**Caso D · Exactamente una coincidencia:** para que la prueba sea reproducible, usa un fichero local de tres líneas como recurso de `curl` (el script admite URLs `file://`):

```bash
printf 'primera línea\nornitorrinco\núltima línea\n' > exercises/prueba.txt
bash exercises/ejercicio5-cli.sh "file://$(pwd)/exercises/prueba.txt" ornitorrinco
```

Resultado esperado:

```text
La palabra "ornitorrinco" aparece 1 vez
Aparece únicamente en la línea 2
```

> Si quieres dejar solo los ficheros originales tras esta prueba, puedes eliminar `exercises/prueba.txt`. El script sobrescribe `exercises/licencia.txt` en cada descarga.
