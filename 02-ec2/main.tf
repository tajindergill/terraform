provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "main" {
  ami           = "ami-0055977a6e828a4f4"
  instance_type = "t3.micro"

  tags = {
    Name = "test"
  }
}

# One resource referring to another resource's attribute.
# Terraform understands the dependency and creates the instance first.
resource "aws_route53_record" "main" {
  zone_id = "Z0066526WCKC4ZSGJG26"
  name    = "test"
  type    = "A"
  ttl     = 30
  records = [aws_instance.main.private_ip]
}


output "private_ip" {
  value = aws_instance.main.private_ip
}
