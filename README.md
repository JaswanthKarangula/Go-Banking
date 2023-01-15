# Go-Banking


## 1 Creating a Database


docker pull postgres:12-alpine

docker exec -it container_name command 

docker exec -it postgres /bin/sh or 

docker exec -it postgres psql -U root

docker logs container_name -->display logs of the container



- Use dbdiagram.io to create a database schema and import the .sql file 
- use the .sql file to create the database
  <img src="/dbschema.png"/>

[//]: # ()
[//]: # (``` psql postgres   ``` <br>)

[//]: # (``` create role Jaswanth with login password 'password'  ```)

[//]: # (<br>)

[//]: # ()
[//]: # ()
[//]: # (``` psql postgres -U jaswanth ```)

[//]: # (<br>)

[//]: # (``` create database simple_bank ```)

## 2 Database Migration 

- Can install go-migrate using brew install golang-migrate  or use it as a library
```
import (
      "github.com/golang-migrate/migrate/v4"
      _ "github.com/golang-migrate/migrate/v4/database/postgres"
      _ "github.com/golang-migrate/migrate/v4/source/github"
      )

        func main() {
        m, err := migrate.New(
        "github://mattes:personal-access-token@mattes/migrate_test",
        "postgres://localhost:5432/database?sslmode=enable")
        m.Steps(2)
        } 

```
- Migrate reads migrations from sources and applies them in correct order to a database.
 - Drivers are "dumb", migrate glues everything together and makes sure the logic is bulletproof. (Keeps the drivers lightweight, too.)
 - Database drivers don't assume things or try to correct user input. When in doubt, fail.
 - ``` migrate -help ```
 - Create a Schema up and down files  ``` migrate create -ext sql -dir db/migration init_schema ```
 - Update the migrate up and down files
 - 

migrate -path db/migration -database "postgres:///root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up