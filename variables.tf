variable "efs_name" {
    type = string
}
variable "efs_mode" {
    description = "EFS Performance Mode. generalPurpose|maxIO"
    type = string
    default = "generalPurpose"
}
variable "efs_default_allow_sg" {
    description = "The security group to add to the EFS Target SG."
    type = string
}
variable "efs_vpc" {
    description = "The VPC to create the EFS Filesystem with."
    type = string
}
variable "efs_subnet_ids" {
    description = "Subnet ID's to create EFS targets on."
    type = list(string)
}
