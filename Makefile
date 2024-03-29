DB_URL=postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable

postgres:
	docker run --name postgres --network bank-network  -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14-alpine

createdb:
	docker exec -it postgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres dropdb simple_bank

migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migrateup1:
	migrate -path db/migration -database "$(DB_URL)" -verbose up 1

migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down

migratedown1:
	migrate -path db/migration -database "$(DB_URL)" -verbose down 1

test:
	go test -v -cover ./...

sqlc:
	sqlc generate
mock:
	mockgen -package mockdb -destination db/mock/store.go  github.com/JaswanthKarangula/Go-Banking/db/sqlc Store
.PHONY:  postgres createdb dropdb migrateup migratedown migrateup1 migratedown1  test mock sqlc