# Laboratorio Linux — Usuarios, Grupos y Permisos

## Contexto General

Todos los escenarios parten desde el siguiente contexto:

* Ya tienes iniciado el contenedor Ubuntu.
* Iniciaste sesión con el usuario:

```bash
estudiante
```

* El usuario `estudiante` pertenece al grupo `sudo`.
* La contraseña de `estudiante` es:

```bash
123456
```

* El objetivo del laboratorio es practicar:

  * usuarios
  * grupos
  * permisos Linux
  * sudo
  * ownership
  * chmod
  * chown
  * chgrp
  * acceso compartido
  * seguridad básica Linux

---

# ESCENARIO 1 — Equipo DevOps Compartiendo Scripts

## Contexto

Una empresa está formando un pequeño equipo DevOps.

Se necesita:

* crear dos usuarios llamados:

  * `ana`
  * `pedro`

* crear un grupo llamado:

```bash
devops
```

* ambos usuarios deben pertenecer al grupo `devops`

* se debe crear una carpeta compartida:

```bash
/automation
```

* únicamente el grupo `devops` debe poder acceder y modificar el contenido de esa carpeta

* el usuario `ana` deberá crear un script llamado:

```bash
backup.sh
```

* el usuario `pedro` debe poder modificar el script

* cualquier otro usuario NO debe poder acceder a la carpeta

---

## Objetivos del reto

Los alumnos deberán descubrir:

* cómo crear usuarios
* cómo crear grupos
* cómo agregar usuarios a grupos
* cómo cambiar ownership
* cómo cambiar permisos
* cómo validar grupos
* cómo verificar permisos
* cómo cambiar entre usuarios

---

## Validaciones esperadas

Al finalizar:

* `ana` y `pedro` deben pertenecer al grupo `devops`
* `/automation` debe pertenecer al grupo `devops`
* la carpeta debe impedir acceso a otros usuarios
* `pedro` debe poder modificar `backup.sh`
* otro usuario externo no debe poder acceder

---

# ESCENARIO 2 — Usuario Invitado Restringido

## Contexto

La empresa quiere crear un usuario temporal para un practicante.

El usuario:

```bash
invitado
```

NO debe tener privilegios administrativos.

Además:

* no debe pertenecer al grupo `sudo`
* no debe poder instalar paquetes
* no debe poder acceder a archivos privados de otros usuarios
* se debe crear una carpeta privada para `ana`
* `invitado` debe intentar acceder y fallar

---

## Objetivos del reto

Los alumnos deberán descubrir:

* cómo crear usuarios normales
* cómo validar grupos
* cómo verificar permisos
* cómo restringir acceso usando chmod
* cómo validar ownership
* cómo probar accesos entre usuarios

---

## Validaciones esperadas

Al finalizar:

* `invitado` NO debe pertenecer a sudo
* `invitado` NO debe poder ejecutar sudo
* `invitado` NO debe poder leer archivos privados de `ana`
* `ana` sí debe poder acceder a sus archivos

---

# ESCENARIO 3 — Equipo Backend y Seguridad de Producción

## Contexto

La empresa tiene un backend crítico.

Se necesita:

* crear un grupo:

```bash
backend
```

* crear usuarios:

  * `appuser`
  * `developer1`

* ambos deben pertenecer al grupo `backend`

* crear una carpeta:

```bash
/app
```

* la carpeta debe pertenecer al grupo `backend`

* únicamente el dueño y el grupo backend pueden acceder

* crear un archivo:

```bash
.env
```

* el archivo `.env` debe ser PRIVADO

* únicamente `appuser` debe poder leerlo y modificarlo

* `developer1` NO debe poder leer el archivo `.env`

---

## Objetivos del reto

Los alumnos deberán descubrir:

* diferencia entre permisos de carpeta y archivo
* permisos 770
* permisos 600
* ownership
* grupos compartidos
* permisos privados
* cómo validar restricciones reales

---

## Validaciones esperadas

Al finalizar:

* `/app` debe ser accesible solo por backend
* `.env` debe ser privado
* `developer1` no debe poder leer `.env`
* `appuser` sí debe poder modificar `.env`

---