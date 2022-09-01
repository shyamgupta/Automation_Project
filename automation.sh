#!/usr/bin/env bash

# Update system packages
sudo apt update -y

# Check if AWS CLI is installed. If not, then install it.
awscli_installed=$(dpkg --list awscli | grep awscli | awk '{print $1}')
if [ awscli_installed = "ii" ];then
	echo "AWS CLI is installed"
else
	echo "Installing AWS CLI"
	sudo apt-get install awscli -y
fi

# Check if apach2 is installed, if not, then install it.
package_name="apache2"
myname="Shyam"
s3BucketName="upgrad-shyamgupta"
apache_installed=$(dpkg --list apache2 | grep apache2 | awk '{print $1}')
if [ apache_installed = "ii"  ]; then
	echo "Apache is installeid"
else
	echo "Installing Apache" 
	sudo apt-get install apache2 -y
fi

#Check if apache2 is running, if not then start it
if [ $(systemctl is-active apache2) = "active"  ]; then
	echo "Apache is running"
else
	echo "Starting Apache"
	sudo systemctl start apache2
fi

#Check if apache2 is enabled, else enable it
apache2_enabled=$(sudo systemctl list-unit-files --type service --state enabled | grep apache2 | awk '{print $2}')
if [ $apache2_enabled="enabled"  ]; then
    echo "Apache is enabled"
else
    sudo systemctl enable apache
fi

# Check if inventory.html exists
file=/var/www/html/inventory.html
if [ -f "$file"  ];then
	echo "inventory.html exists"
else
	touch $file
	printf "<pre>Log Type\t\tDate Created\t\tType\tSize</pre>">$file
fi

#Create tar of apache2 access and error logs under /tmp
timestamp=$(date '+%d%m%Y-%H%M%S')
accesslog=$myname-httpd-access-logs-$timestamp.tar
errorlog=$myname-httpd-error-logs-$timestamp.tar
tar -Pcvf /tmp/$accesslog  /var/log/apache2/access.log
accessLogSize=$(ls -lh /tmp/$accesslog | awk '{print $5}')
tar -Pcvf /tmp/$errorlog  /var/log/apache2/error.log
errorLogSize=$(ls -lh /tmp/$errorlog | awk '{print $5}')

#Copy access and error log tar files to S3 Bucket
aws s3 cp /tmp/$accesslog s3://$s3BucketName
printf "<pre>HTTPD Access Log\t$timestamp\t\ttar\t$accessLogSize</pre>">> $file
aws s3 cp /tmp/$errorlog s3://$s3BucketName
printf "<pre>HTTPD Error Log\t\t$timestamp\t\ttar\t$errorLogSize</pre>">> $file
