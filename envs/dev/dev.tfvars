region="ap-south-1"
env="dev"
vpc_cidr_range="10.0.0.0/16"
public_subnet_cidrs=["10.0.1.0/24", "10.0.2.0/24"]
private_subent_cidrs=["10.0.3.0/24", "10.0.4.0/24"]

health_check_path="/healthz"
ecs_cluster_name="ecs-django"
ecs_service_name="django-app"
docker_image_url="229704422334.dkr.ecr.ap-south-1.amazonaws.com/django-app:latest"
cpu="256"
memory="512"
desired_count=2
log_retention_in_days=30

autoscale_min=1
autoscale_max=10