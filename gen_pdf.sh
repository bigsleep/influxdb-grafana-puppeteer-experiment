#!/bin/bash

usage() {
    echo "Usage: $0 input_file dashboard_name output_path" 1>&2
    exit 1
}

if [ $# -ne 3 ]; then
    usage
fi

input_file="$1"
dashboard_name="$2"
dashboard_uid="$dashboard_name"
output_path="$3"
output_directory=$(dirname "$output_path")
output_file=$(basename "$output_path")
grafana_url="http://grafana:3000/d/${dashboard_uid}/${dashboard_name}/"

docker-compose run --rm -v "$output_directory:/output" puppeteer "$(cat $input_file)" "$grafana_url" "$output_file" &&
    docker-compose down
