#!/bin/bash

usage() {
    echo "Usage: $0 input_file dashboard_name output_path" 1>&2
    exit 1
}

if [ $# -ne 3 ]; then
    usage
fi

input_path="$1"
input_file=$(basename "$input_path")
dashboard_name="$2"
dashboard_uid="$dashboard_name"
output_path="$3"
output_file=$(basename "$output_path")
grafana_url="http://grafana:3000/d/${dashboard_uid}/${dashboard_name}?kiosk=true"

docker-compose up --no-start &&
    docker cp "$input_path" "$(docker-compose ps -q puppeteer):/volume/" &&
    docker-compose run --rm --use-aliases --user="$(id -u):$(id -g)" puppeteer "/volume/$input_file" "$grafana_url" "$output_file" &&
    docker cp "$(docker-compose ps -q puppeteer):/volume/$output_file" "$output_path" &&
    docker-compose run --rm --no-deps --user="$(id -u):$(id -g)" --entrypoint '' puppeteer rm "/volume/$input_file" "/volume/$output_file" &&
    docker-compose down
