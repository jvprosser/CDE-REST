#!/bin/bash

RESOURCE_SCEHEDULER='https://yunikorn.cde-9x78z7kk.jing-pub.a465-9q4k.cloudera.site/'

WORKLOAD_USER="XXXXXX"
export GRAFANA_CHARTS="https://service.cde-ntvvr5hx.go01-dem.ylcu-atmi.cloudera.site/grafana/d/0Oq0WmQWk/instance-metrics?orgId=1&refresh=5s&var-virtual_cluster_name=Spark351"

CDE_TOKEN=$(curl -u ${WORKLOAD_USER} $(echo ${GRAFANA_CHARTS} | cut -d'/' -f1-3 | awk '{print $1"/gateway/authtkn/knoxtoken/api/v1/token"}') | jq -r '.access_token')
export CDE_JOB_URL="https://4spcd2c8.cde-ntvvr5hx.go01-dem.ylcu-atmi.cloudera.site/dex/api/v1"

# curl -v -H "Authorization: Bearer ${CDE_TOKEN}" -X POST "${CDE_JOB_URL}/resources" -H "Content-Type: application/json"  -H "Accept: */*"-d "{ \"name\": \"jvp-testiceberg\"}"


curl -v  -X POST  -H "Authorization: Bearer ${CDE_TOKEN}"  -H "Content-Type: application/json"  -H "Accept: */*" "${CDE_JOB_URL}/jobs/jvp-testiceberg/run"
