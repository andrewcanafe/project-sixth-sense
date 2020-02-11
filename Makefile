include .env

install:
	cd backend && make install && make build-base

build-frontend:
	cd frontend && npm run dev > /dev/null 2>&1 &
	
prod: build-frontend
	docker build . -t chefmoji-prod
	docker run -p $(SERVER_PORT):$(SERVER_PORT) chefmoji-prod

debug-prod: build-frontend
	docker build . -t chefmoji-prod
	docker run -p $(SERVER_PORT):$(SERVER_PORT) -it chefmoji-prod sh