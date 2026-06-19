resource "aws_instance" "web" {
    ami = "ami-123456789"
    instance_type = var.instance_type

    tags = {
        Environment = var.environment
    }
}