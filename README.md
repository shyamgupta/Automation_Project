# Problem Statement - Task 3
## Bash Script Information
The bash script performs the following activities on an Ubuntu EC2 instance:
- Perform an update of package details
- Install apache2 if not already installed
- Start and Enable apache2 service
- Creates /var/www/html/inventory.html if it doesn't exist
- Creates a tar archive of apache2 error and access logs stored in /var/logs/apache2/ directory
- Copies the tar archives to an AWS S3 bucket
- Updates /var/www/html/inventory.html with the httpd access log and error log entries

Script is located at /root/"Automation_Project"/ directory of the EC2 instance.
EC2 instance security group has inbound rules for SSH (port 22) and HTTP (port 80) from anywhere
An IAM role (with S3 Full Access permissions) is attached to the EC2 instance.

## Cron Job
- Cron entry for "automation" created under `/etc/cron.d/` and is scheduled to run daily as root user

## How to run the script manually
1. Switch to root use using `sudo su`
2. Ensure script has execute permissions, `chmod a+x automation.sh`
3. Execute `/root/Automation_Project/automation.sh`

