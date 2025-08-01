resource "aws_ecs_cluster" "main" {
  name = "journal-cluster"
}

resource "aws_ecs_task_definition" "journal" {
  family                   = "api-task"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([
    {
    name      = "api"
    image     = "${var.ecr_image}"
    essential = true
    portMappings = [
    {
      containerPort = 80
      hostPort      = 80
      protocol      = "tcp"
        }
    ]
    environment = [
            {
            name  = "DATABASE_URL"
            value = "postgresql://${var.db_user}:${var.db_password}@${var.db_endpoint}/${var.db_name}"
            }
        ]
    }
  ])
}

resource "aws_ecs_service" "journal" {
  name            = "journal-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.journal.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = true
    security_groups  = [var.security_group_id]
  }
}
