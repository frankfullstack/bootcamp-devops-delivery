# Ejercicio 2 - CLI

## Objetivo

Volcar el contenido de `file1.txt` a `file2.txt` y mover `file2.txt` al directorio `empty` mediante comandos de Bash.

## Solución

Partiendo de la estructura creada en el ejercicio 1 y desde el directorio `exercises`, ejecutamos los siguientes comandos:

### 1. Copiar el contenido de file1.txt a file2.txt

```bash
cat foo/dummy/file1.txt > foo/dummy/file2.txt
```

### 2. Mover file2.txt al directorio empty

```bash
mv foo/dummy/file2.txt foo/empty/
```

## Resultado esperado

```text
foo/
├── dummy/
│   └── file1.txt
└── empty/
    └── file2.txt
```

Ambos ficheros contienen el texto "Me encanta la bash!!".

## Verificación

```bash
tree foo
cat foo/dummy/file1.txt
cat foo/empty/file2.txt
diff -s foo/dummy/file1.txt foo/empty/file2.txt
```

La última línea debe mostrar algo como:

```
Files foo/dummy/file1.txt and foo/empty/file2.txt are identical
```