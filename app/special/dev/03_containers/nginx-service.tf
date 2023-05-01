variable "nginx_envvars" {
  type        = map(string)
  description = "variables to set in the environment of the container"
  default = {
  }
}

resource "aws_ecs_task_definition" "nginx_task_def" {
  family                   = "${local.env}-${local.app_name}-task-family"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = 256
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  container_definitions = templatefile("./nginx.json.tpl", {
    aws_ecr_repository = local.nginx_repository_url
    image_tag          = local.nginx_image_tag
    app_port           = 80
    region             = local.region
    prefix             = "${local.env}-${local.app_name}"
    envvars            = var.nginx_envvars
    port               = 80
  })
}

resource "aws_ecs_service" "nginx_service" {
  name            = "${local.env}-${local.app_name}-nginx-service"
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.nginx_task_def.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = data.terraform_remote_state.infrastructure.outputs.private_subnets
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.alb_tg.arn
    container_name   = "${local.env}-${local.app_name}-nginx"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.http_forward, aws_lb_listener.https_forward, aws_iam_role_policy_attachment.ecs_task_execution_role]
}
