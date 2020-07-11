FROM python:3.6-alpine

ENV MONGO bbr-mongodb
ENV MONGO_PORT 27017
ENV RMQ_HOST bbr-rabbitmq
ENV RMQ_QUEUE bbr-queue
ENV RMQ_USERNAME admuser
ENV RMQ_PASSWORD admpass
ENV CHECK_INTERVAL 5
ENV EXCLUDE_URLS '.*github.com'

COPY . /app
WORKDIR /app

RUN pip install -r requirements.txt
RUN apk --no-cache add curl

ENTRYPOINT [ "./crawler_entrypoint.sh" ]
