#!/bin/sh

if [ $# -ne 3 ]; then
    echo 'not enough arguemnts'
    exit
fi

input_data="$1"
url="$2"
output_file="$3"

curl -i -XPOST http://influxdb:8086/query --data-urlencode 'q=CREATE DATABASE db' &&
    curl -i -XPOST 'http://influxdb:8086/write?db=db' --data-urlencode "$input_data" &&
    node save_pdf.js "$url" "/output/$output_file"
