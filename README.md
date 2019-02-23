# docker_jupyter_mongo
Dockerfile and docker-compose files for running jupyter lab and mongoDB
**Use case:**
1. Adjust `Dockerfile` and `docker-compose` to map desired directories to containers.
2. Do `docker-compose build` to build.
3. Do `docker compose up` to run containers.
4. Navigate to http://0.0.0.0:8888/lab to see Jupyter Lab running.
5. Try to connect to MongoDB, the IP address of Mongo instance is name of the Docker container that runs Mongo.
Part of connection string could be something like `@jupyterlab_docker_mongo_1:27017/some_db`.

If connection to Mongo from Jupyter Lab container is not working, then create some users
for database as described [here](https://medium.com/rahasak/enable-mongodb-authentication-with-docker-1b9f7d405a94).

After these steps, everything should be working (2 docker containers running, one for Jupyter, another one for mongo)
and Mongo instance should be accesible from Jupyter.

