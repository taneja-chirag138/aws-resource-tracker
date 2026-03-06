# aws-resource-tracker
AWS Resource Monitoring Script using AWS CLI, Cron and Email Alerts


### **_AWS Resource Tracker with Email Alerts_**

Author: Chirag
Date: 5 March 2026
Version: v1

### Project Description

This project is a Bash automation script that monitors AWS resources using AWS CLI and sends the output through email notifications.

The script collects information about:

AWS S3 Buckets

AWS EC2 Instances

AWS Lambda Functions

AWS IAM Users

The script is automated using cron jobs and the results are stored in a log file and emailed using Gmail SMTP.

**### 1. System Update**
sudo apt update
Purpose

Updates the package index from Ubuntu repositories so the system installs the latest versions of packages.

**### 2. Install Required Utilities**
sudo apt install curl unzip
Purpose
Package	Work
curl	Used to download files from the internet
unzip	Extracts compressed zip files
3. Verify Installation
curl -v

_Shows curl version and connection capability._

unzip -v

_Shows unzip version._

**### 4. Download AWS CLI**
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
Purpose

Downloads the AWS CLI installation package from the official AWS website.

**### 5. Extract AWS CLI Package**
unzip awscliv2.zip

Extracts the downloaded AWS CLI zip file.

**### 6. Install AWS CLI**
sudo ./aws/install
Purpose

Installs AWS CLI on the system.

**### 7. Verify AWS CLI Installation**
aws --version

Example output:

aws-cli/2.x Python/3.x Linux/x86_64

Confirms AWS CLI is installed successfully.

**### 8. Configure AWS CLI**
aws configure

You will be asked to provide:

Field	Description
AWS Access Key	IAM access key
AWS Secret Key	IAM secret key
Default Region	AWS region (example: ap-south-1)
Output Format	json

_Configuration files are stored in:_

~/.aws/credentials
~/.aws/config

_Check them using:_

cat ~/.aws/credentials
cat ~/.aws/config

**### 9. Create AWS Resource Tracker Script**
nano aws_resource_tracker.sh

**Script content:**

#!/bin/bash

#####################
# Author : Chirag
# Date : 5 March ,2026
# Version : v1
# This script will report the AWS resource usage
#####################

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
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'

#### Listing Lambda Functions
echo "Listing Lambda Functions"
aws lambda list-functions

#### Listing IAM Users
echo "Listing IAM Users"
aws iam list-users
10. Run Script
./aws_resource_tracker.sh

Runs the script and displays AWS resource information.

**### 11. Create Log File**
touch /root/aws_resource.log

**Creates a log file to store script output.

Check logs:**

cat aws_resource.log

or

tail -f /root/aws_resource.log

**### 12. Automate Script Using Cron**

**Open cron editor:**

crontab -e

**Add cron job:**

*/5 * * * * /root/aws_resource_tracker.sh >> /root/aws_resource.log 2>&1
_Cron Explanation
Part	Meaning_
_*/5	Every 5 minutes

| Append output to log file |
2>&1 | Redirect errors to the same log file |_

_Check cron jobs:_

crontab -l

**### 13. Install Mail Utilities**
sudo apt install mailutils
_Purpose_

Provides the mail command used to send emails from the Linux terminal.

**### 14. Test Local Mail**
echo "Test message" | mail -s "Local Test" root

_Check local mailbox:_

cat /var/mail/root

_Mail logs:_

sudo tail -f /var/log/mail.log

**### 15. Install SMTP Client**
sudo apt install msmtp

_Purpose_

msmtp is a lightweight SMTP client used to send emails via Gmail.

**### 16. Configure msmtp**

_Create configuration file:_

nano /root/.msmtprc

_Example configuration:_

defaults
auth on
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account gmail
host smtp.gmail.com
port 587
user USERNAME
password YOUR_APP_PASSWORD
from MAIL ID

_account default : gmail

Secure file:_

chmod 600 /root/.msmtprc

**### 17. Test Gmail SMTP**
echo "Hello Gmail!" | msmtp --debug --from=chiragtaneja138@gmail.com taneja.chirag138@gmail.com

This sends a test email using Gmail SMTP.

**### 18. Link msmtp with sendmail**
sudo ln -sf /usr/bin/msmtp /usr/sbin/sendmail

This makes the Linux mail command use msmtp instead of postfix.

**### 19. Send Email using Mail Command**
echo "Test mail from EC2" | mail -s "Test Subject" taneja.chirag138@gmail.com

Now the email is delivered to Gmail.

**### 20. Automate Email Alerts**

_Edit cron:_

crontab -e

_Add:_

*/5 * * * * /root/aws_resource_tracker.sh | mail -s "AWS Resource Report" taneja.chirag138@gmail.com

This sends the AWS resource report every 5 minutes.

**### 21. Monitor Cron Logs**
grep CRON /var/log/syslog

_Shows cron job execution logs._

**### Project Workflow**
AWS Cloud
     ↓
AWS CLI
     ↓
Bash Script
     ↓
Cron Job
     ↓
Log File
     ↓
Email Notification (Gmail SMTP)
