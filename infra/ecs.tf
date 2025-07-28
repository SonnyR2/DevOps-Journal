resource "aws_ecs_cluster" "main" {
  name = "journal-cluster"
}


resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Effect = "Allow"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_ecs_task_definition" "journal" {
  family                   = "api-task"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode            = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "api"
      image     = "${var.ecr_image}" # ECR or DockerHub
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol = "tcp"
        }
      ]
      environment = [
        {
          name  = "DATABASE_URL"
          value = "postgresql://${var.db_user}:${var.db_password}@${aws_db_instance.postgres.endpoint}/${var.db_name}"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "journal" {
  name            = "api-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.journal.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.public["public-1"].id, aws_subnet.public["public-2"].id]
    assign_public_ip = true
    security_groups  = [aws_security_group.sg["allow_traffic"].id]
  }
}
