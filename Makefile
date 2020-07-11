DOCKER_MACHINE_NAME=docker-host
PROJECT_HUB=otusprojectbbr
MONGODB_EXPORTER_VERSION=v0.11.0

docker_machine_create:
	docker-machine create --driver google \
	--google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts \
	--google-machine-type \
	n1-standard-1 \
	--google-zone \
	europe-west1-b \
	${DOCKER_MACHINE_NAME}

docker_machine_delete:
	docker-machine rm ${DOCKER_MACHINE_NAME}

crawler_app_firewall_rule_add:
	gcloud compute firewall-rules create search-app \
	--allow tcp:8000 \
	--target-tags=docker-machine \
	--description="Allow Crawler connections" \
	--direction=INGRESS

rabbitmq_firewall_rule_add:
	gcloud compute firewall-rules create rabbitmq \
	--allow tcp:15672 \
	--target-tags=docker-machine \
	--description="Allow rabbitmq webui" \
	--direction=INGRESS

prometheus_firewall_rule_add:
	gcloud compute firewall-rules create prometheus \
	--allow tcp:9090 \
	--target-tags=docker-machine \
	--description="Allow prometheus webui" \
	--direction=INGRESS

grafana_firewall_rule_add:
	gcloud compute firewall-rules create grafana \
	--allow tcp:3000 \
	--target-tags=docker-machine \
	--description="Allow grafana webui" \
	--direction=INGRESS

create_gcp_service_account:
	gcloud iam service-accounts create sa-bbr-project \
	--description="sa-for-otus-project" \
	--display-name="sa-bbr-project"

create_gcp_service_account_key:
	gcloud iam service-accounts keys create ~/key.json \
	--iam-account sa-bbr-project@otus-project-2020.iam.gserviceaccount.com

build_rabbitmq:
	cd ./src/rabbitmq && docker build -t ${PROJECT_HUB}/rabbitmq:1.0 .

push_rabbitmq:
	docker push ${PROJECT_HUB}/rabbitmq:1.0

build_prometheus:
	cd ./monitoring/prometheus && docker build -t ${PROJECT_HUB}/prometheus .

push_prometheus:
	docker push ${PROJECT_HUB}/prometheus

build_alertmanager:
	cd ./monitoring/alertmanager && docker build -t ${PROJECT_HUB}/alertmanager .

push_alertmanager:
	docker push ${PROJECT_HUB}/alertmanager

clone_mongodb_exporter:
	test -d "./monitoring/mongodb_exporter" || (cd ./monitoring && git clone https://github.com/percona/mongodb_exporter.git)

build_mongodb_exporter: clone_mongodb_exporter
	cd ./monitoring/mongodb_exporter && \
	make docker DOCKER_IMAGE_NAME=${PROJECT_HUB}/mongodb-exporter DOCKER_IMAGE_TAG=${MONGODB_EXPORTER_VERSION}

push_mongodb_exporter:
	docker push ${PROJECT_HUB}/mongodb-exporter:${MONGODB_EXPORTER_VERSION}

build_blackbox_exporter:
	docker build -t ${PROJECT_HUB}/blackbox-exporter:latest 'https://github.com/bitnami/bitnami-docker-blackbox-exporter.git#master:0/debian-10'

push_blackbox_exporter:
	docker push ${PROJECT_HUB}/blackbox-exporter:latest

build_crawler:
	cd ./src/search_engine_crawler && docker build -t ${PROJECT_HUB}/search-crawler:1.0 .

push_crawler:
	docker push ${PROJECT_HUB}/search-crawler:1.0
