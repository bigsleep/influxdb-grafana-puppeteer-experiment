#!/bin/sh

if [ $# -ne 3 ]; then
    echo 'not enough arguemnts'
    exit
fi

input_path="$1"
url="$2"
output_file="$3"

sleep 10

curl -i -XPOST 'http://influxdb:8086/query' --data-urlencode 'q=CREATE DATABASE db'
curl -i -XPOST 'http://influxdb:8086/write?db=db&precision=s' --data-binary "@${input_path}"
node save_pdf.js "$url" "/volume/$output_file"
