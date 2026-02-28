# Step 1 : Create IAM role for ecs
resource "aws_iam_role" "ecs-task-execution-role" {
    name = "ecs_task_execution_role-${var.env}"
    assume_role_policy = file("policies/ecs-assume-role.json") 
}

# Step 2: Create IAM role policy for task
resource "aws_iam_role_policy" "ecs-task-execution-role-policy" {
    name = "ecs_task-execution_role_policy_${var.env}"
    role = aws_iam_role.ecs-task-execution-role.id
    policy = file("policies/ecs-task-execution-policy.json")
}

# Step 3: Create ECS service role
resource "aws_iam_role" "ecs-service-role" {
    name = "ecs_service_role-${var.env}"
    assume_role_policy = file("policies/ecs-assume-role.json") 
}

# Step 4: Create IAM role policy for service
resource "aws_iam_role_policy" "ecs-service-role-policy" {
  name = "ecs-service-role-policy-${var.env}"
  role = aws_iam_role.ecs-service-role.id
  policy = file("policies/ecs-service-role-policy.json")
}

