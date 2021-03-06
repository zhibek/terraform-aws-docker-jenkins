# terraform-aws-docker-jenkins

A simple example of using `Terraform` to provision `Jenkins` (CI/CD) using its official `Docker` image in a `Docker` container on an `AWS` `EC2` instance.

Going beyond this example, it would be important to structure the `Terraform` files and think carefully about where secrets were stored.


## Instructions for use

1) Ensure you have a valid `AWS` account, including an `access_key` and `secret_key` for a user with permissions to create the necessary resources.  
If you don't have an `AWS` account you can sign up to the Free Tier here: https://aws.amazon.com/free/  
Export your `access_key` and `secret_key`:  
```
export AWS_ACCESS_KEY_ID="access_key"
export AWS_SECRET_ACCESS_KEY="<secret_key>"
```

2) Download `Terraform` if you don't already have it installed:  
https://www.terraform.io/intro/getting-started/install.html

3) Populate `terraform.tfvars` with relevant values, using `terraform.tfvars.example` as an example.

4) Create a `key pair` for use on the `AWS` `EC2` instances and put the `public`/`private` keys in `.private/aws-key.pem.pub`/`.private/aws-key.pem`.

5) Use `Terraform` to check how the services will be provisioned:  
```
terraform plan
```

6) Provision using `Terraform`:  
```
terraform apply
```

7) Check the output of the provision and access the server via SSH and/or your web browser.  
```
## Provision output...
...
Apply complete! Resources: 11 added, 0 changed, 0 destroyed.

Outputs:

aws_instance-ci-public_dns = <hostname>.compute-1.amazonaws.com
aws_platform-name = okappy-global-us-east-1
...
```

```
## Access server via SSH and Docker
ssh -i .private/aws-key.pem ubuntu@<hostname>.compute.amazonaws.com
sudo docker ps
sudo docker exec -it <container-id> bash
```

```
## Access server via HTTP
lynx http://<hostname>.compute.amazonaws.com:8080/
```

8) Complete Jenkins setup by finding the `/var/jenkins_home/secrets/initialAdminPassword` file via SSH and entering the contents in the HTTP interface (the HTTP interface should prompt you to do this). Then follow the instructions provided, installing standard plugins and creating the first admin account.

9) Try out Jenkins, by adding a `Multibranch Pipeline` job such as: https://github.com/zhibek/behat-example.git  
This job type relies on the `Jenkinsfile` inside the `git` repo, therefore no additional config is required in the `Jenkins` UI.

10) If there is a need to re-stage the server at any point, `taint` and re-`apply` via `Terraform`:  
```
terraform taint aws_instance.ci
terraform apply
```
