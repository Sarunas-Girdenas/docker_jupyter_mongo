### Jupyterlab & Postgres

Dockerfile and docker-compose.yml configs to be used together
1. Adjust `Dockerfile` and `docker-compose.yml` files to map to desired ports/destinations on host machine
2. Do `docker-compose build` to build
3. Then `docker-compose up`
4. Two docker container are running: one on localhost:8888/lab - JupyterLab, the other one on localhost:5432 - postgres
5. To connect from JupyterLab container to Postgres:
`PGPASSWORD=change_me psql -h postgres -p 5432 -U root -d init_database`
and could use the same connection string to connect using pandas.
