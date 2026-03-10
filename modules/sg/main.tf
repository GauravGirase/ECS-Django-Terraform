# SG - ALB (Allowing external traffic)
resource "aws_security_group" "alb_sg" {
    vpc_id = var.vpc_id
    name = "Security group for ALB"
    description = "SG for alb for http and https traffic"
    
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/1"]
    }

    egress {
        to_port = 0
        from_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

# ECS Farget security group (traffic ALB -> ECS Farget Tasks)
resource "aws_security_group" "ecs-sg" {
    name = "ecs_farget_security_group"
    description = "Allow inbount traffic from ALB only"
    vpc_id = var.vpc_id

    # We can restric to the specific ports later
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [aws_security_group.alb_sg.id]
    }

     # We can restric to the specific ports later
    ingress {
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        security_groups = [aws_security_group.alb_sg.id]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


