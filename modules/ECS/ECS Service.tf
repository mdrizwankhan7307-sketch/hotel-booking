resource "aws_ecs_service" "this" {

  name = "${var.project_name}-service"

  cluster = aws_ecs_cluster.this.id

  task_definition = aws_ecs_task_definition.this.arn

  desired_count = var.desired_count

  launch_type = "FARGATE"

  network_configuration {

    subnets = var.private_subnet_ids

    security_groups = [

      var.ecs_security_group_id

    ]

    assign_public_ip = false

  }

  load_balancer {

    target_group_arn = var.target_group_arn

    container_name = var.project_name

    container_port = var.container_port

  }

  depends_on = [

    aws_iam_role_policy_attachment.execution

  ]
}