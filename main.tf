resource "aws_efs_file_system" "efs" {
    encrypted         = true
    performance_mode = var.efs_mode
    throughput_mode                 = "bursting"
    provisioned_throughput_in_mibps = 0
    tags                            = {
        Name = var.efs_name
    }

#    lifecycle_policy {
#        transition_to_ia = "AFTER_60_DAYS"
#    }
}

resource "aws_security_group" "sg_efs" {
    description = "EFS Access for all in default sg"
    egress =  [ {
        description      = "Allow all outgoing"
        from_port        = 0
        to_port          = 0
        cidr_blocks      = [
            "0.0.0.0/0",
        ]
        ipv6_cidr_blocks = []
        prefix_list_ids  = []
        protocol         = "-1"
        security_groups  = []
        self             = false
    } ]
    ingress = [ {
        description      = "NFS Mount for all systems"
        protocol         = "tcp"
        from_port        = 2049
        to_port          = 2049
        cidr_blocks      = []
        ipv6_cidr_blocks = []
        prefix_list_ids  = []
        security_groups  = [
            var.efs_default_allow_sg,
        ]
        self             = false
    } ]
    name        = "sg_efs_access ${var.efs_name}"
    tags        = { Name = "sg_${var.efs_name}",
                    EFS  = var.efs_name }
    vpc_id      = var.efs_vpc

    timeouts {}
}


resource "aws_efs_mount_target" "private_targets" {
    count = length(var.efs_subnet_ids)
    file_system_id = aws_efs_file_system.efs.id
    subnet_id      = var.efs_subnet_ids[count.index]

    security_groups = [   aws_security_group.sg_efs.id ]
#    tags = { Name = "efs_target ${var.efs_name}",
#             EFS = var.efs_name }
}
