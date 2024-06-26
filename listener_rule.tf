#Generates a random number in the given range
resource "random_integer" "priority" {
  min = 100
  max = 500
}

  # Creates a rule in the PRIVATE load balancer listener 

resource "aws_lb_listener_rule" "app_rule" {
    count      = var.INTERNAL ? 1 : 0 

    listener_arn = data.terraform_remote_state.alb.outputs.PRIVATE_LISTENER_ARN
    priority     = random_integer.priority.result

    action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.app.arn
  }

    condition {
        host_header {
        values = ["${var.COMPONENT}-${var.ENV}.${data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_NAME}"]
        }
    }
}