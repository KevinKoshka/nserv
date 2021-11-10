### Setup de configuración local
- Setear constraseña del usuario `root` de  MariaDB con `$ export MYSQL_ROOT_PASSWORD=PASSWORD`.
- Para generar un lock de las dependencias `$ deno cache --lock=lock.json --lock-write src/deps.ts`.
- Para solo descargar las dependencias en cache `$ deno cache deps.ts`.
- Para correr el server `$ deno run --allow-net src/main.ts`. El flag `--watch` levanta el servidor con live reload, `--inspect` corre la app en un sandbox de chromium para poder abrirlo con el inspector de chrome, y `--inspect-brk` hace lo mismo pero permite breakpoints.
- Alternativamente se puede correr `$ ./nserv.sh run-inspect` o `$ ./nserv.sh run-watch`.
- Para acceder al inspector de chrome ir a `chrome://inspect/#devices`.

### Setup de configuracion remota
1. Correr `$ docker pull denoland/deno` y `$ docker pull mariadb`.
2. Cargar el dump de la base de datos `$ docker exec -i nserv_db_1 sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < /mnt/c/Users/kevin/Nserv/mkdb.sql`.