DOCKER_MACHINE_NAME=docker-host

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
