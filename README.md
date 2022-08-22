# This is a simple CI-CD using Jenkins Configuration as Code and Terraform on AWS
![](readme_img/demo1-shema.png)

### To run CI-CD, follow these steps:

1. install terraform, git, curl, jq  

2. You must have an account on AWS, GitHub, Docker Hub

3. clone this repository
```
git clone https://github.com/612284/jenkins-casc-on-aws-by-terraform.git
```
4. enter your credentials to the terraform.tfvars file

```
env                     = "dev"
region                  = "eu-central-1"
instance_type           = "t2.micro"
jenkins_login           = "admin"
jenkins_pass            = "123456"
jenkins_key_name        = "your-existed-ssh-key-name-on-aws-for-ec2"
docker_hub_login        = "xxxxxxxx"
docker_hub_password     = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
docker_hub_repo         = "xxxxxxx/xxxxxxxxxxxx"
worker_user             = "ubuntu"
worker_appserv_key_name = "name-created-here-ssh-key-for-worker-and-appserv"
git_hub_token           = "ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
git_hub_repo_app        = "https://github.com/612284/flask-app.git"
git_hub_repo_pipeline   = "https://github.com/612284/jenkins-casc-on-aws-by-terraform.git"
git_hub_repo_web_hook   = "https://api.github.com/repos/612284/flask-app/hooks"
```
and secret.sh file
```
#!/bin/bash
export git_hub_token=ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
export git_hub_user=USER
export git_hub_repo=REPO
```
5. create 2 files to add AWS credentials

~/.aws/credentials
```
[default]
aws_access_key_id = your_access_key_id
aws_secret_access_key = your_secret_access_key
```
~/.aws/config
```
[default]
region = your_aws_region
```

or run in terminal
```
export AWS_ACCESS_KEY_ID=your_access_key_id
export AWS_SECRET_ACCESS_KEY=your_secret_access_key
export AWS_REGION=your_aws_region
```


6. run Terraform
```
terraform init
terraform plan
terraform apply
```
![](readme_img/Aspose.Words.2ad6179e-d187-4343-985e-9e302ef68375.001.png)

Go to Jenkins and enjoy the work
![](readme_img/Aspose.Words.2ad6179e-d187-4343-985e-9e302ef68375.002.png)

We go to Prod and check the page

![](readme_img/Aspose.Words.2ad6179e-d187-4343-985e-9e302ef68375.003.png)
