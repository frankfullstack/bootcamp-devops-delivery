# Ejercicio 1 - CLI

## Objetivo

Crear mediante comandos de Bash una jerarquía de directorios y ficheros, donde `file1.txt` contenga el texto "Me encanta la bash!!" y `file2.txt` permanezca vacío.

## Solución

Desde el directorio `exercises`, ejecutamos los siguientes comandos:

### 1. Crear los directorios necesarios

```bash
mkdir -p foo/{dummy,empty}
```

### 2. Crear los ficheros

```bash
touch foo/dummy/file{1,2}.txt
```

### 3. Escribir el contenido en file1.txt

```bash
echo 'Me encanta la bash!!' > foo/dummy/file1.txt
```

## Resultado esperado

```text
foo/
├── dummy/
│   ├── file1.txt
│   └── file2.txt
└── empty/
```

- `file1.txt` contiene el texto "Me encanta la bash!!".
- `file2.txt` permanece vacío.

## Verificación

```bash
tree foo
cat foo/dummy/file1.txt
cat foo/dummy/file2.txt
```