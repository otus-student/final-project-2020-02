FROM rabbitmq:3.8.5-management

ADD rabbitmq.conf /etc/rabbitmq/
ADD definitions.json /etc/rabbitmq/

RUN rabbitmq-plugins enable rabbitmq_prometheus
