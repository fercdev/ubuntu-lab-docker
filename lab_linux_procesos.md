# Laboratorio Completo - Gestión de Procesos en Linux

## Objetivo

Al finalizar este laboratorio serás capaz de:

* Identificar procesos y sus PID.
* Comprender la relación Padre-Hijo (PID y PPID).
* Entender qué es un TTY.
* Trabajar con procesos foreground y background.
* Pausar y reanudar procesos.
* Inspeccionar procesos desde `/proc`.
* Identificar la carpeta de trabajo de un proceso.
* Utilizar señales (signals).
* Diferenciar SIGTERM y SIGKILL.
* Simular procesos huérfanos (Orphan).
* Simular procesos zombie.
* Analizar estados de procesos.

---

# Escenario 1 - Explorando el Shell Actual

## Paso 1 - Verificar usuario

```bash
whoami
```

### Resultado esperado

```text
estudiante
```

---

## Paso 2 - Obtener el PID de tu shell

```bash
echo $$
```

### Ejemplo

```text
45
```

Tu resultado será diferente.

Este es el PID del proceso bash actual.

---

## Paso 3 - Ver procesos asociados a tu terminal

```bash
ps
```

### Posible resultado

```text
PID TTY          TIME CMD
45 pts/0    00:00:00 bash
80 pts/0    00:00:00 ps
```

### Validación

Debes ver:

* bash
* ps

Ambos asociados al mismo TTY.

---

## Paso 4 - Verificar TTY actual

```bash
tty
```

### Posible resultado

```text
/dev/pts/0
```

### Validación

Debe coincidir con la columna TTY mostrada por `ps`.

---

# Escenario 2 - Inspeccionando Procesos

## Paso 1

```bash
ps aux
```

### Observar

Columnas importantes:

```text
USER
PID
TTY
STAT
COMMAND
```

---

## Paso 2

Mostrar más detalle:

```bash
ps -ef
```

### Observar

```text
UID
PID
PPID
CMD
```

---

## Paso 3

Ver árbol de procesos

```bash
pstree
```

Si no existe:

```bash
sudo apt update
sudo apt install psmisc
```

### Posible resultado

```text
bash---pstree
```

---

# Escenario 3 - Crear Procesos Manualmente

## Paso 1

Ejecutar:

```bash
sleep 300
```

La terminal quedará bloqueada.

---

## Paso 2

Abrir una segunda terminal

```bash
docker exec -it <container_id> bash
```

---

## Paso 3

Buscar el proceso

```bash
ps aux | grep sleep
```

### Posible resultado

```text
estudiante 120 0.0 0.0 sleep 300
```

### Validación

Debe aparecer:

```text
sleep 300
```

---

## Paso 4

Ver padre e hijo

```bash
ps -o pid,ppid,state,cmd -p 120
```

### Posible resultado

```text
PID PPID S CMD
120 45 S sleep 300
```

---

# Escenario 4 - Entender Estados de Procesos

## Running

Crear carga de CPU:

```bash
yes > /dev/null
```

Abrir otra terminal:

```bash
ps aux | grep yes
```

### Estado esperado

```text
R
```

---

## Sleeping

```bash
sleep 300
```

### Estado esperado

```text
S
```

---

## Stopped

Ejecutar:

```bash
sleep 500
```

Presionar:

```text
CTRL + Z
```

### Resultado esperado

```text
[1]+ Stopped sleep 500
```

### Estado esperado

```text
T
```

Verificar:

```bash
ps aux | grep sleep
```

---

# Escenario 5 - Foreground y Background

## Paso 1

Ejecutar:

```bash
sleep 500
```

---

## Paso 2

Pausar

```text
CTRL + Z
```

---

## Paso 3

Ver jobs

```bash
jobs
```

### Resultado esperado

```text
[1]+ Stopped sleep 500
```

---

## Paso 4

Enviar al background

```bash
bg
```

### Resultado esperado

```text
[1]+ sleep 500 &
```

---

## Paso 5

Verificar

```bash
jobs
```

### Resultado esperado

```text
Running
```

---

## Paso 6

Traer nuevamente al foreground

```bash
fg
```

---

# Escenario 6 - Encontrar la Carpeta de un Proceso

## Paso 1

Crear un proceso desde un directorio específico

```bash
mkdir proyecto
cd proyecto
sleep 300 &
```

---

## Paso 2

Obtener PID

```bash
jobs -l
```

Ejemplo:

```text
[1]+ 210 Running sleep 300 &
```

---

## Paso 3

Consultar carpeta actual

```bash
pwdx 210
```

### Posible resultado

```text
210: /home/estudiante/proyecto
```

---

## Método alternativo

```bash
ls -l /proc/210/cwd
```

### Posible resultado

```text
cwd -> /home/estudiante/proyecto
```

---

# Escenario 7 - Explorar /proc

## Paso 1

Ver PID del shell

```bash
echo $$
```

Ejemplo:

```text
45
```

---

## Paso 2

Explorar

```bash
ls /proc/45
```

---

## Paso 3

Ver estado

```bash
cat /proc/45/status
```

Buscar:

```text
State
PPid
Threads
VmSize
```

---

## Paso 4

Ver ejecutable

```bash
ls -l /proc/45/exe
```

### Posible resultado

```text
/usr/bin/bash
```

---

# Escenario 8 - Signals

## Ver señales disponibles

```bash
kill -l
```

### Posible resultado

```text
1) SIGHUP
2) SIGINT
9) SIGKILL
15) SIGTERM
```

---

# Escenario 9 - Diferencia entre SIGTERM y SIGKILL

## Crear proceso

```bash
sleep 1000 &
```

Obtener PID:

```bash
jobs -l
```

---

## Enviar SIGTERM

```bash
kill PID
```

o

```bash
kill -15 PID
```

### Qué ocurre

Linux solicita al proceso finalizar.

---

## Verificar

```bash
ps -p PID
```

No debería existir.

---

## Crear nuevamente

```bash
sleep 1000 &
```

---

## Enviar SIGKILL

```bash
kill -9 PID
```

### Qué ocurre

Linux destruye inmediatamente el proceso.

No puede ignorar esta señal.

---

## Diferencia

| Signal  | Comportamiento       |
| ------- | -------------------- |
| SIGTERM | Terminación elegante |
| SIGKILL | Terminación forzada  |

---

# Escenario 10 - Simular Orphan Process

## Terminal 1

```bash
sleep 1000 &
```

Obtener PID:

```bash
jobs -l
```

Ejemplo:

```text
[1]+ 220 Running sleep 1000 &
```

---

## Cerrar Terminal 1

```bash
exit
```

---

## Terminal 2

Buscar proceso:

```bash
ps -o pid,ppid,cmd -p 220
```

### Posible resultado

```text
PID PPID CMD
220 1 sleep 1000
```

---

## Validación

PPID = 1

Significa que fue adoptado por el proceso init.

Es un Orphan Process.

---

# Escenario 11 - Simular Zombie Process

## Crear archivo

```bash
nano zombie.py
```

---

## Código

```python
import os
import time

pid = os.fork()

if pid > 0:
    time.sleep(300)
else:
    print("Hijo terminando")
    os._exit(0)
```

---

## Ejecutar

```bash
python3 zombie.py
```

---

## Abrir segunda terminal

Buscar zombies:

```bash
ps aux | grep defunct
```

o

```bash
ps aux | grep Z
```

---

## Posible resultado

```text
Z
<defunct>
```

---

## Validación

El hijo terminó.

El padre sigue vivo.

El padre no ejecutó:

```python
wait()
```

Por eso el hijo queda zombie.

---

# Escenario 12 - Analizando Estados de Procesos

## Mostrar estados

```bash
ps aux
```

Buscar columna:

```text
STAT
```

---

## Estados más comunes

| Estado | Significado |
| ------ | ----------- |
| R      | Running     |
| S      | Sleeping    |
| T      | Stopped     |
| Z      | Zombie      |

---

# Escenario 13 - Matar Procesos por Nombre

## Crear varios procesos

```bash
sleep 1000 &
sleep 1000 &
sleep 1000 &
```

---

## Buscar

```bash
pgrep sleep
```

---

## Matar todos

```bash
pkill sleep
```

---

## Verificar

```bash
pgrep sleep
```

No debería devolver resultados.

---

# Escenario 14 - Resumen Final

Al finalizar deberías ser capaz de identificar:

| Concepto               | Cómo Validarlo |
| ---------------------- | -------------- |
| PID                    | ps             |
| PPID                   | ps -ef         |
| TTY                    | tty            |
| Foreground             | fg             |
| Background             | bg             |
| Signals                | kill -l        |
| SIGTERM                | kill PID       |
| SIGKILL                | kill -9 PID    |
| Directorio del proceso | pwdx PID       |
| Ejecutable             | /proc/PID/exe  |
| Estado                 | ps aux         |
| Zombie                 | defunct        |
| Orphan                 | PPID=1         |
| Árbol de procesos      | pstree         |
| Información interna    | /proc          |

```
```
