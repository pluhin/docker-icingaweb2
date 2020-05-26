# Icingaweb2 Container

This is container for k8s deployment. All configuration settings could be added in k8s cluster like config maps (example: resources.ini)

* Alpine based
* Requires PostgreSQL with existing DBs
  * icingaweb_db - Icinga Web credential
  * icinga_ido - Icinga2 monitoring data
* Docker-Healthcheck support

### Example

**To run

```bash
sudo docker run \
  --rm -t \
  --name icingaweb2 \
  -p 8080:80 \
  -e TIMEZONE=Europe/Minsk \
  pluhin31/icinga2-web
```

## Likns

https://blog.sleeplessbeastie.eu/2018/01/15/how-to-install-icinga2-and-icingaweb2/


## Maintainer
* Siarhei Pishchyk <pluhin@gmail.com>
