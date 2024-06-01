# Creates app component records against the ALB
resource "aws_route53_record" "docdb_dns" {
  zone_id = var.INTERNAL ? data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_ID : data.terraform_remote_state.vpc.outputs.PUBLIC_HOSTED_ZONE_ID
  name    = "mongodb-${var.ENV}.${data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_NAME}"
  type    = "CNAME"
  ttl     = 10
  records = []
}