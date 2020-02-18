# efs_filesystem
 Terraform module to create EFS filesystem


#### Input Variables
variable | type | description
----- | -----| -----
efs_name | string | Name to be used for EFS volume and associated resources
efs_mode | string | generalPurpose or MaxIO
efs_default_allow_sg | string | The SG to add to the new EFS security group
efs_vpc | string | The VPC to create the new filesystem in
efs_subnet_ids | list(string) | List of subnet IDs to create EFS Targets for

Set the provider and region in your terraform.

#### example
```terraform
provider "aws" {
    region = "us-west-2"
}
module "EFS_FileSystem" {
    source = "../modules/efs_filesystem"

    efs_name = "efs_test2"
    efs_mode = "maxIO"
    efs_default_allow_sg = "sg-00111111111111111"
    efs_vpc = "vpc-22222222222222222"
    efs_subnet_ids = [ "subnet-03333333333333333",
                            "subnet-04444444444444444",
                            "subnet-55555555555555555",
                            "subnet-66666666666666666",  ]
}

resource "aws_route53_record" "test_efs" {
  zone_id = "Z32WLVJV333333"
  name    = "test_efs.aws.example.com"
  type    = "CNAME"
  ttl     = "60"
  records = [module.EFS_FileSystem.efs_dns]
}


