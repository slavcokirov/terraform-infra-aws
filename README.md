# Deploying AWS infrastructure using Terraform

## General information

Terraform is tool used as a infrastructure as code deployments.
Drone CI is used for automated deployment.

## Deployments

1. Add AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY as drone secrets
2. Edit the s3.tf file(s3 bucket names are unique)
3. Edit the versions.tf file(same as s3.tf file)
4. Push to your remote git repository to trigger a drone ci deployment

## Branches

* *main* branch: Used for automated deployments.
* *feature* branches: Infrastructure development.

### Note

The docker image in .drone.yml is created using the Dockerfile.
You can create your own docker image using the same file.

## Further improvements

* Add multiple environments.
* Add shared modules.
* Add automated tests.
