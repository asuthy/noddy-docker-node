# noddy 
### node app running in a Docker container connecting to a postgres Docker container with reload on code change and VS Code debugging
#### Create and run postgres container
```console
docker run -p 5432:5432 --name postgres-10 -e POSTGRES_PASSWORD=postgres -d postgres:10
```
#### Build image
```console
docker build -t noddy:0.0.1 .
```
#### Run container with link to postgres-10 container (available internally as postgres)
```console
docker run --name noddy -p 9229:9229 -p 3000:3000 --link postgres-10:postgres -d -v ${PWD}:/home/node/app noddy:0.0.1
```
#### Attach VS Code debugger from debug menu
```console
DEBUG > Docker: Attach to Node
```
#### Make request and hit breakpoints
```console
http://localhost:3000/?publication=SM&start=30-Sep-2018&end=27-Oct-2018
```

#### View logs
```console
docker logs noddy
```
#### Connect terminal into the container
```console
docker exec -it noddy bash
```
#### Stop the container
```console
docker stop noddy
```
#### Remove the container
```console
docker logs noddy
```