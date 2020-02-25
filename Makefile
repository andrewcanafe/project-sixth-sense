include .env

install:
	cd backend && make install && make build-base
	find backend -name chefmoji.pem && cp $(find backend -name chefmoji.pem) chefmoji.pem

build-base:
	cd backend && make build-base

install-frontend:
	npm install protobufjs
	make build-frontend

build-frontend:
	cd frontend && npm run build

build-prod: build-frontend
	docker build . -t $(BACKEND_REPO)

prod: build-prod
	docker run -p $(SERVER_PORT):$(SERVER_PORT) -p $(MYSQL_PORT):$(MYSQL_PORT) $(BACKEND_REPO)

debug-prod: build-prod
	docker run -p $(SERVER_PORT):$(SERVER_PORT) -p $(MYSQL_PORT):$(MYSQL_PORT) -it $(BACKEND_REPO) sh

# Authenticate Docker client
ecr-login:
	$(shell aws ecr get-login --no-include-email --region us-west-1)

ec2-login:
	ssh -i $(PEM_FILE) ec2-user@$(EC2_IP)

push: build-base build-prod ecr-login
	docker tag $(BACKEND_REPO):latest $(ECR_URI)/$(BACKEND_REPO):latest
	docker push $(ECR_URI)/$(BACKEND_REPO):latest
	scp -i $(PEM_FILE) backend/nginx/conf/nginx.conf ec2-user@$(EC2_IP):nginx.conf
