# terraform-infra-aws

This document is a source of all necessary information about an example terraform infrastucture, aimed for devops on this project.

## General information

Terraform is used as a infrastructure as code tool deployments.

## Usage

Steps:

1. cd <repo_dir>
2. Initiate the remote storage state:
```teraform init```
3. Plan changes:
```terraform plan -var-file="prod.tfvars"```
4. Create a PR into *main* branch.

## Deployments

Deployments are automated when merging into *main* branch using Drone CI.

## Branches

* *main* branch: Used for automated deployments.
* *feature* branches: Infrastructure development.

## Further improvements

* Add multiple environments.
* Add shared modules.
* Add automated tests.
