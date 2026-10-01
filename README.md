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

# 2. Validate syntax
terraform validate

# 3. Create execution plan
terraform plan

# 4. Apply configurations
terraform apply

# 5. Check the outputs available
terraform output
```

5. Verify a resource through the AWS CLI

```shell
aws --endpoint-url http://localhost:4566 \
  s3api head-bucket --bucket floci-terraform-example
```

6. Additional Activity: Try importing the resources that have been created imperatively via `setup.sh`
- s3 bucket: tfstate
- dynamodb: tflock

7. Stuck on how to import the resources? Refer to the following official documentation
- **S3 bucket**: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import
- **DynamoDB**: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table#import

8. Stuck on how to generate the configurations? Ensure you have defined the import block for the resource above first and run the following command

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