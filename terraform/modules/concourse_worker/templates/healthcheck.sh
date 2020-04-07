#!/usr/bin/env bash
HEADERS=$(curl -Is --connect-timeout 5 http://127.0.0.1:8888)
CURLSTATUS=$?
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document|grep region|awk -F\" '{print $4}')
INSTANCE_ID=$(wget -q -O - http://169.254.169.254/latest/meta-data/instance-id)

# Check for timeout
if [ $CURLSTATUS -eq 28 ]
then
    echo "Connection timeout, unhealthy"
    aws autoscaling set-instance-health --region $REGION --instance-id $INSTANCE_ID --health-status Unhealthy
else
    # Check HTTP status code
    HTTPSTATUS=`echo $HEADERS | grep HTTP | cut -d' ' -f2`
    if [ $HTTPSTATUS -le 399 ]
    then
        echo "Healthy"
        aws autoscaling set-instance-health --region $REGION --instance-id $INSTANCE_ID --health-status Healthy
    else
        echo "Unhealthy"
        aws autoscaling set-instance-health --region $REGION --instance-id $INSTANCE_ID --health-status Unhealthy
    fi
fi
