resource "aws_lb_target_group" "this" {

  name = "${var.project_name}-tg"

  port = var.target_port

  protocol = "HTTP"

  vpc_id = var.vpc_id

  target_type = "ip"

  health_check {

    enabled = true

    path = "/"

    protocol = "HTTP"

    matcher = "200"

    interval = 30

    timeout = 5

    healthy_threshold = 2

    unhealthy_threshold = 2

  }

  tags = {
    Name = "${var.project_name}-tg"
  }
}