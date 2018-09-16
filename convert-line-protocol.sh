#!/bin/bash

while IFS=, read timestamp api_name response_time memory_usage; do
    printf "stress_test_sample,api_name=%s response_time=%.1f,memory_usage=%.1f %d\n" $api_name $response_time $memory_usage $timestamp
done
