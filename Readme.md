### Pre-requisites
- (aws cli installed)[https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html]
- (aws cli configured)[https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html]
- (terraform cli)[https://learn.hashicorp.com/tutorials/terraform/install-cli]

### How To Deploy
1. In terraform folder, edit main.tf and make necessary changes

2. From inside the terraform directory run

terraform plan
terraform apply

### How to update
1. Make any changes to the templates under ghost_instance_configs and jenkins will update the instance in place


### TO DO
- setup email (Simple Email Service?) for cronjob
- implement cron job (command in coammnds.txt)
- create non-interactive jenkins setup w/groovy scripts
- setup S3 bucket for backups
- Setup Route 53