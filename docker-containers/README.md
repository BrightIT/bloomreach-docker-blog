# Run Bloomreach applications in docker containers

## Requirements
- [docker](https://docs.docker.com/install/) installed on your local machine
- [docker-compose](https://docs.docker.com/compose/install/) installed (ver. min 1.23.2)

## Running docker containers

### Prepare the base image first
Go to root dir of this project, where main `pom.xml` is located and execute the following commands:
```
mvn clean verify
mvn -P dist-with-development-data
cd docker-containers
./build_base_image.sh
```

## Running local environment (containers)
We use docker-compose to run all needed containers. Important things to rememeber:
* you have to be in folder where `docker-compose.yml` is present
* the `.env` file keeps variables used by docker-compose
* WAR files are linked to containers from `target` folders (check `docker-compose.yml` **volume** sections for details)

Use the following commands to run the local env

command | outcome
--- | ---
`docker-compose up -d auth` | runs only authoring container with database
`docker-compose up -d auth site-1` | runs authoring and one instance of delivery/runtime
`docker-compose up -d` | run all containers
`docker-compose ps` | shows status of running containers
`docker-compose stop` | stop all running containers
`docker-compose rm` | remove stopped containers but leave volumes (database) and network intouched
`docker-compose down -v` | **Warning!** this will remove all containers, volumes, networks etc. Total cleanup (will not remove WAR files in `target` folders)
 | 
