#!/bin/sh

set -e

container="rabbitmq"
port="15672"
cmd="python -u crawler/crawler.py https://vitkhab.github.io/search_engine_test_site/"

>&2 echo "Checking container rabbitmq for available..."
until curl -i -u admuser:admpass http://$container:$port/api/vhosts; do
  >&2 echo "Container rabbitmq is not available, trying..."
  sleep 1
done

>&2 echo "Container rabbitmq is avaialable, start main command"

exec $cmd
