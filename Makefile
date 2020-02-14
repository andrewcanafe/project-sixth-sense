include .env

install:
	cd backend && make install && make build-base

build-base:
	cd backend && make build-base

build-frontend:
	cd frontend && npm run build > /dev/null 2>&1 &

build-prod: build-frontend
	docker build . -t $(BACKEND_REPO)
	
prod: build-prod
	docker run -p $(SERVER_PORT):$(SERVER_PORT) -p $(MYSQL_PORT):$(MYSQL_PORT) $(BACKEND_REPO)

debug-prod: build-prod
	docker run -p $(SERVER_PORT):$(SERVER_PORT) -p $(MYSQL_PORT):$(MYSQL_PORT) -it $(BACKEND_REPO) sh

# Authenticate Docker client
ecr-login:
	$(shell aws ecr get-login --no-include-email --region us-west-1)

push: build-base build-prod ecr-login
	docker tag $(BACKEND_REPO):latest $(ECR_URI)/$(BACKEND_REPO):latest
	docker push $(ECR_URI)/$(BACKEND_REPO):latest