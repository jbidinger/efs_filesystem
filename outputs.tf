output "efs_id" {
    value = aws_efs_file_system.efs.id
}
output "efs_dns" {
    value = aws_efs_file_system.efs.dns_name
}
output "efs_sg" {
    value = aws_security_group.sg_efs.id
}
output "efs_targets_subnet_id" {
    value = aws_efs_mount_target.private_targets.*.subnet_id 
}
output "efs_targets_subnet_dns_name" {
    value = aws_efs_mount_target.private_targets.*.dns_name
}