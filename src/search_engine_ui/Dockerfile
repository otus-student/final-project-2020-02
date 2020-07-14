FROM python:3.7-alpine

ENV MONGO bbr-mongodb
ENV MONGO_PORT 27017
ENV FLASK_APP ui.py

COPY . /app
WORKDIR /app/ui

RUN pip install -r /app/requirements.txt

ENTRYPOINT ["gunicorn", "--bind", "0.0.0.0", "ui:app"]
