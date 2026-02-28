terraform {
    backend "s3" {
        name = "terrformstate-ecs-django"
        key = "dev/terraform.tfstate"
        encrypt = true
        lock = true
        region = var.region
    }
}