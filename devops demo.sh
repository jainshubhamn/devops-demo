#!/bin/bash
# Use this for your user data (httpd package installation along with DataDog Agent)
# install httpd (Linux 2 version)
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1> HRMS Web App $(hostname -f)</h1>" > /var/www/html/index.html
DD_API_KEY=f1790b58491cdd4d9faa91b7fa82ae5e DD_SITE="datadoghq.eu" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"
systemctl start datadog-agent
systemctl enable datadog-agent



logs:
- type: file
    path: /var/log/httpd/access_log
    source: apache
    sourcecategory: log_poc
    service: ctl_logs_poc  
- type: file
    path: /var/log/httpd/error_log
    source: apache
    sourcecategory: log_poc
    service: ctl_logs_poc

logs:
  - type: file
    path: /var/log/httpd/access_log
    source: apache
    sourcecategory: log_poc
    service: ctl_logs_poc

  - type: file
    path: /var/log/httpd/error_log
    source: apache
    sourcecategory: log_poc
    service: ctl_logs_poc