#!/bin/bash




#####################
# Author : Chirag
# Date : 5 March ,2026
#Version : v1


#This script will report the AWS resource usage
########################




# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM User

set -x

#### Listing S3 buckets
echo "Listing S3 buckets"
aws s3 ls

#### Listing EC2 instance
echo "Listing EC2 instance"
#aws ec2 describe-instances
sudo aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'


#### Listing Lambda Functions
echo "Listing Lambda Functions"
aws lambda list-functions

#### Listing IAM Users
echo"Listing IAM Users"
aws iam list-users

