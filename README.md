# Problem Statement - Task 2
## Bash Script Information
The bash script performs the following activities on an Ubuntu EC2 instance:
- Perform an update of package details
- Install apache2 if not already installed
- Install AWS CLI if not installed
- Start and Enable apache2 service
- Creates a tar archive of apache2 error and access logs and stores them in /tmp

Script is located at /root/"Automation_Project"/ directory of the EC2 instance.
EC2 instance security group has inbound rules for SSH (port 22) and HTTP (port 80) from anywhere
An IAM role (with S3 Full Access permissions) is attached to the EC2 instance.


## How to run the script manually
1. Switch to root use using `sudo su`
2. Ensure script has execute permissions, `chmod a+x automation.sh`
3. Execute `/root/Automation_Project/automation.sh`

