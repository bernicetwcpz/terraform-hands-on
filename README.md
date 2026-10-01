# terraform-hands-on
Using floci to emulate AWS to practice Terraform

## Additional Notes
floci also supports emulating GCP and Azure. For this setup, it is using AWS as the target cloud provider. Refer to https://github.com/floci-io/floci-cli for more information


# Prerequisites
Please ensure the following tools are installed
- Visual Studio Code (vscode)
- [VSCode Extension: Hashicorp Terraform ](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)
    - Useful for autocomplete
- Docker (if planning to run floci with Docker)
- Floci (with brew)


# Get Started

1. Install floci with `brew install floci-io/floci/floci`

2. Run `floci start`

3. Alternatively, you can start floci using docker if you have Docker installed and do not wish to install floci CLI

```shell
docker compose up -d
```

3. Ensure you are in the terraform-hands-on directory and run `source setup.sh`


# Hands-on Activity
1. Run the commands in the following order

```shell
# 1. Initialize working directory
terraform init

# 2. Format the configuration files
terraform fmt

# 3. Validate syntax
terraform validate

# 4. Create execution plan
terraform plan
```
2. Now create a `terraform.tfvars` file and run `terraform fmt`
```shell
prefix           = "floci"
environment      = "local"
create_s3_bucket = false
```

3. Create a execution plan
```shell
# 1. Create execution plan
terraform plan
```

4. Check that the resources are reflecting the intended values as defined in the terraform.tfvars

5. Activity 1: What is the options required to take in the variable file?
```shell
terraform plan -help
```
6. Apply configurations 

```shell
terraform apply <include variable file>
```

7. Check the outputs available
```shell
terraform output
```

8. Verify a resource through the AWS CLI

```shell
aws --endpoint-url http://localhost:4566 \
  s3api head-bucket --bucket floci-terraform-example
```

9. **Activity 2**: Try importing the resources that have been created imperatively via `setup.sh`
- s3 bucket: tfstate
- dynamodb: tflock

10. Stuck on how to import the resources? Refer to the following official documentation
- **S3 bucket**: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import
- **DynamoDB**: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table#import

11. Stuck on how to generate the configurations? Ensure you have defined the import block for the resource above first and run the following command

```shell
terraform plan -generate-config-out=generated_resources.tf
```
 
# Cleanup
1. Remove local resources
    - Don't do this in production!
```shell
terraform destroy
```

2. Stop floci
```shell
# floci CLI
floci stop

# Docker compose
docker-compose down
```