module "web" {
    source = "./modules/ec2"

    instance_type = "t2.micro"
    environment = "dev"
}

output "server_id" {
    value = module.web.instance_id
}