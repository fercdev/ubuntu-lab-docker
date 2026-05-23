# Laboratorio Linux — Streams, Pipes y Procesamiento de Texto

## Objetivo

En este laboratorio aprenderás a utilizar comandos fundamentales de Linux relacionados con:

- stdout
- stdin
- stderr
- pipes
- tee
- env
- cut
- head
- tail
- join
- split
- sort
- tr
- uniq
- wc
- nl
- grep

Todo el laboratorio está pensado para ejecutarse dentro del contenedor Ubuntu Docker que creaste anteriormente.

---

# Requisitos

Debes tener:

- Docker instalado
- La imagen Ubuntu creada anteriormente
- El contenedor ejecutándose

---

# Levantar el laboratorio

## Construir imagen

```bash
docker build -t ubuntu-lab .
```

---

## Ejecutar container

```bash
docker run -it --name laboratorio-linux ubuntu-lab
```

---

# Crear carpeta del laboratorio

Dentro del contenedor ejecuta:

```bash
mkdir -p ~/laboratorio-linux
cd ~/laboratorio-linux
```

Verifica:

```bash
pwd
```

Salida esperada:

```txt
/home/estudiante/laboratorio-linux
```

---

# 1. STDOUT

# ¿Qué es STDOUT?

STDOUT significa:

```txt
Standard Output
```

Es la salida estándar de un programa.

Normalmente:
- aparece en pantalla
- representa resultados exitosos

---

# Ejemplo básico

```bash
echo "Hola Linux"
```

Salida:

```txt
Hola Linux
```

Eso es STDOUT.

---

# Redireccionar STDOUT

Crear archivo:

```bash
echo "Hola desde stdout" > salida.txt
```

Verificar:

```bash
cat salida.txt
```

---

# Agregar contenido sin sobrescribir

```bash
echo "Segunda linea" >> salida.txt
```

Verifica:

```bash
cat salida.txt
```

---

# 2. STDERR

# ¿Qué es STDERR?

STDERR significa:

```txt
Standard Error
```

Representa errores producidos por programas.

---

# Ejemplo básico

```bash
ls carpeta-que-no-existe
```

Salida:

```txt
ls: cannot access 'carpeta-que-no-existe': No such file or directory
```

Ese mensaje viaja por STDERR.

---

# Redireccionar STDERR

```bash
ls carpeta-inexistente 2> errores.txt
```

Verifica:

```bash
cat errores.txt
```

---

# Explicación del 2>

Linux usa descriptores:

| Descriptor | Significado |
|---|---|
| 0 | stdin |
| 1 | stdout |
| 2 | stderr |

Por eso:

```bash
2>
```

redirecciona errores.

---

# 3. STDIN

# ¿Qué es STDIN?

STDIN significa:

```txt
Standard Input
```

Es la entrada estándar.

Normalmente:
- teclado
- archivos
- pipes

---

# Ejemplo usando cat

Ejecuta:

```bash
cat
```

Ahora escribe:

```txt
Hola
Linux
```

Presiona:

```txt
CTRL + D
```

Eso envía EOF (End Of File).

---

# Ejemplo usando archivo como STDIN

Crear archivo:

```bash
echo "Linea 1" > entrada.txt
echo "Linea 2" >> entrada.txt
```

Usar STDIN:

```bash
cat < entrada.txt
```

---

# 4. Pipes

# ¿Qué es un Pipe?

Un pipe conecta:

```txt
stdout de un comando
```

con:

```txt
stdin de otro comando
```

Se representa con:

```bash
|
```

---

# Ejemplo básico

```bash
history | less
```

Explicación:

- history genera salida
- less recibe esa salida

---

# Ejemplo 2

```bash
ls -la | grep txt
```

Explicación:

- ls muestra archivos
- grep filtra solo txt

---

# Ejemplo 3

```bash
cat salida.txt | wc -l
```

Cuenta líneas.

---

# 5. Tee

# ¿Qué hace tee?

tee:

- muestra salida en pantalla
- y además la guarda en un archivo

---

# Ejemplo básico

```bash
echo "Hola Tee" | tee archivo-tee.txt
```

Verifica:

```bash
cat archivo-tee.txt
```

---

# Agregar contenido

```bash
echo "Nueva linea" | tee -a archivo-tee.txt
```

---

# Ejemplo práctico

```bash
ls -la | tee listado.txt
```

---

# 6. env

# ¿Qué hace env?

Muestra variables de entorno.

---

# Ejemplo básico

```bash
env
```

---

# Buscar una variable específica

```bash
env | grep HOME
```

---

# Crear variable temporal

```bash
export APP_NAME="laboratorio-linux"
```

Verificar:

```bash
env | grep APP_NAME
```

---

# 7. cut

# ¿Qué hace cut?

Extrae columnas o caracteres.

---

# Crear archivo CSV

```bash
cat > usuarios.csv <<EOF
1,Juan,Backend
2,Ana,Frontend
3,Carlos,DevOps
EOF
```

Verifica:

```bash
cat usuarios.csv
```

---

# Obtener columna nombres

```bash
cut -d ',' -f2 usuarios.csv
```

---

# Obtener área

```bash
cut -d ',' -f3 usuarios.csv
```

---

# Obtener múltiples columnas

```bash
cut -d ',' -f1,2 usuarios.csv
```

---

# 8. head

# ¿Qué hace head?

Muestra primeras líneas.

---

# Ejemplo básico

```bash
head usuarios.csv
```

---

# Mostrar primeras 2 líneas

```bash
head -n 2 usuarios.csv
```

---

# Probar con archivo grande

```bash
history > historial.txt
head historial.txt
```

---

# 9. tail

# ¿Qué hace tail?

Muestra últimas líneas.

---

# Ejemplo básico

```bash
tail usuarios.csv
```

---

# Mostrar últimas 2 líneas

```bash
tail -n 2 usuarios.csv
```

---

# Monitoreo en tiempo real

Terminal 1:

```bash
tail -f logs.txt
```

Terminal 2:

```bash
echo "nuevo log" >> logs.txt
```

---

# 10. join

# ¿Qué hace join?

Une archivos usando una columna común.

---

# Crear archivo empleados

```bash
cat > empleados.txt <<EOF
1 Juan
2 Ana
3 Carlos
EOF
```

---

# Crear archivo áreas

```bash
cat > areas.txt <<EOF
1 Backend
2 Frontend
3 DevOps
EOF
```

---

# Ejecutar join

```bash
join empleados.txt areas.txt
```

Salida esperada:

```txt
1 Juan Backend
2 Ana Frontend
3 Carlos DevOps
```

---

# 11. split

# ¿Qué hace split?

Divide archivos grandes.

---

# Crear archivo grande

```bash
seq 1 100 > numeros.txt
```

---

# Dividir archivo

```bash
split -l 20 numeros.txt parte_
```

---

# Ver resultado

```bash
ls parte_*
```

---

# Revisar contenido

```bash
cat parte_aa
```

---

# 12. sort

# ¿Qué hace sort?

Ordena contenido.

---

# Crear archivo

```bash
cat > nombres.txt <<EOF
Carlos
Ana
Juan
Pedro
EOF
```

---

# Ordenar alfabéticamente

```bash
sort nombres.txt
```

---

# Orden inverso

```bash
sort -r nombres.txt
```

---

# Orden numérico

```bash
sort -n numeros.txt
```

---

# 13. tr

# ¿Qué hace tr?

Transforma caracteres.

---

# Convertir minúsculas a mayúsculas

```bash
echo "linux docker" | tr 'a-z' 'A-Z'
```

---

# Reemplazar caracteres

```bash
echo "2026-01-01" | tr '-' '/'
```

---

# Eliminar caracteres

```bash
echo "abc123" | tr -d '0-9'
```

---

# 14. uniq

# ¿Qué hace uniq?

Elimina líneas repetidas consecutivas.

---

# Crear archivo

```bash
cat > repetidos.txt <<EOF
apple
apple
banana
banana
banana
linux
EOF
```

---

# Aplicar uniq

```bash
uniq repetidos.txt
```

---

# Contar ocurrencias

```bash
uniq -c repetidos.txt
```

---

# Importante

uniq funciona correctamente si el archivo está ordenado.

---

# Ejemplo correcto

```bash
sort repetidos.txt | uniq
```

---

# 15. wc

# ¿Qué hace wc?

Cuenta:

- líneas
- palabras
- caracteres

---

# Contar líneas

```bash
wc -l usuarios.csv
```

---

# Contar palabras

```bash
wc -w usuarios.csv
```

---

# Contar caracteres

```bash
wc -c usuarios.csv
```

---

# 16. nl

# ¿Qué hace nl?

Numera líneas.

---

# Ejemplo básico

```bash
nl usuarios.csv
```

---

# Guardar salida numerada

```bash
nl usuarios.csv > usuarios-numerados.txt
```

---

# Usar con pipe

```bash
cat usuarios.csv | nl
```

---

# 17. grep

# ¿Qué hace grep?

Busca patrones dentro de texto.

---

# Buscar palabra

```bash
grep "Juan" usuarios.csv
```

---

# Ignorar mayúsculas

```bash
grep -i "juan" usuarios.csv
```

---

# Buscar múltiples coincidencias

```bash
grep "DevOps" usuarios.csv
```

---

# Buscar recursivamente

```bash
grep -r "Juan" .
```

---

# 18. Laboratorio Integrador

Ahora realizarás ejercicios combinando varios comandos.

---

# Escenario 1 — Buscar usuarios DevOps

```bash
cat usuarios.csv | grep DevOps
```

---

# Escenario 2 — Obtener solo nombres

```bash
cat usuarios.csv | cut -d ',' -f2
```

---

# Escenario 3 — Ordenar nombres

```bash
cat usuarios.csv | cut -d ',' -f2 | sort
```

---

# Escenario 4 — Contar líneas

```bash
cat usuarios.csv | wc -l
```

---

# Escenario 5 — Guardar logs usando tee

```bash
history | tee historial-completo.txt
```

---

# Escenario 6 — Numerar resultados

```bash
cat usuarios.csv | nl
```

---

# Escenario 7 — Convertir a mayúsculas

```bash
cat nombres.txt | tr 'a-z' 'A-Z'
```

---

# Escenario 8 — Buscar errores

```bash
ls carpeta-inexistente 2> error.log
cat error.log
```

---

# Escenario 9 — Ordenar y eliminar repetidos

```bash
sort repetidos.txt | uniq
```

---

# Escenario 10 — Mostrar primeras líneas

```bash
cat historial.txt | head -n 5
```

---

# Limpieza del laboratorio

Eliminar archivos creados:

```bash
rm -rf *.txt *.csv parte_*
```

---

# Conceptos importantes aprendidos

Durante este laboratorio aprendiste:

- manejo de streams Linux
- stdin
- stdout
- stderr
- pipes
- procesamiento de texto
- búsqueda de patrones
- transformación de contenido
- conteo y ordenamiento
- manipulación de archivos

---

# Recomendación final

Practica combinando comandos.

En Linux es muy común construir pipelines como:

```bash
cat archivo.txt | grep error | sort | uniq | wc -l
```

Ese tipo de composición es una de las características más poderosas de Unix/Linux.

---