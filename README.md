# Icingaweb2 Container

* Icingaweb2 v2.7.3
* Alpine based
* Requires PostgreSQL
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
  -v $PWD/conf:/etc/icingaweb2 \
  pluhin31/icinga2-web
```


### Configuration via ENV Vars:

* `TIMEZONE=UTC`: Timezone
* `ICINGAWEB_AUTOCONFIG=true`: Set to false to disable auto configuration
* `ICINGA_API_PASS`: Password Icinga2 API user `icingaweb2` 

#### MySQL for Icingaweb
* `WEB_DB_HOST=pgsql`: Database Host
* `WEB_DB_PORT=5432`: Database Port
* `WEB_DB_USER=???`: Database User
* `WEB_DB_PASS=???`: Database Password
* `WEB_DB=icingaweb2`: Database Name

#### MySQL for Icinga IDO
* Uses Icingaweb connection if not specified
* `IDO_DB_HOST=pgsql`: Database Host
* `IDO_DB_PORT=5432`: Database Port
* `IDO_DB_USER=???`: Database User
* `IDO_DB_PASS=???`: Database Password
* `IDO_DB=icinga`: Database Name


## Maintainer
* Siarhei Pishchyk <pluhin@gmail.com>
