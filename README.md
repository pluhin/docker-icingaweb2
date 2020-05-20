# Icingaweb2 Container

This is container for k8s deployment. All configuration settings could be added in k8s cluster like config maps (example: resources.ini)

* Icingaweb2 v2.8.0-rc1
* Alpine based
* Requires PostgreSQL with existing DBs
  * icingaweb_db - Icinga Web credential
  * icinga_ido - Icinga2 monitoring data
* Docker-Healthcheck support

**Exposed Volume: `/etc/icingaweb2`**: Icingaweb2 Config Files  
**Exposed Port: `80`**: Icingaweb2 HTTP Port

### Supported tags

* Exact: i.e. `2.4.2-r1`: Icingaweb2 Version 2.4.2, image build 1
* `2.4`: Icingaweb2 Version 2.4.x, latest image build
* `2`: Icingaweb2 Version 2.x.x, latest image build

### Example

See [docker-compose.yml](): Icinga2 stack with UI and Graphing **(TODO)**  

**To run

```bash
sudo docker run \
  --rm -t \
  --name icingaweb2 \
  -p 8080:80 \
  -e TIMEZONE=Europe/Minsk \
  -e ICINGA_API_PASS=damn-secret \
  -e WEB_DB_PASS=top-secret \
  pluhin31/icinga2-web
```


### Configuration via ENV Vars:




## Maintainer
* Siarhei Pishchyk <pluhin@gmail.com>
