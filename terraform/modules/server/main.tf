provider "aws" {  
    region = "us-east-2"
}


# Network
resource "aws_vpc" "test-env" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "test-env"
  }
}
resource "aws_eip" "ip-test-env" {
  instance = aws_instance.warg.id
  vpc      = true
}


# Subnets
resource "aws_subnet" "subnet-uno" {
  cidr_block = "${cidrsubnet(aws_vpc.test-env.cidr_block, 3, 1)}"
  vpc_id = aws_vpc.test-env.id
  availability_zone = "us-east-2a"
}

resource "aws_route_table" "route-table-test-env" {
  vpc_id = "${aws_vpc.test-env.id}"
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.test-env-gw.id}"
  }
  
  tags = {
    Name = "test-env-route-table"
  }
}
#łącznik 
resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.subnet-uno.id}"
  route_table_id = "${aws_route_table.route-table-test-env.id}"
}


# Security group
resource "aws_security_group" "example" {

    name = "terraform-example-instance"
    
    vpc_id = "${aws_vpc.test-env.id}"
    
    ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  
// Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
 
 }


 # Server
 resource "aws_instance" "warg" {
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.test_profile.name
  key_name = "terraform-example"
  #below add to security group my own, per sevrice
  vpc_security_group_ids = ["${aws_security_group.example.id}"]
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y awscli
              mkdir /home/ubuntu/test
              chown ubuntu:ubuntu /home/ubuntu/test
              EOF

  tags = {
    Name = "terraform-example"
  }
  subnet_id = "${aws_subnet.subnet-uno.id}"
}


# Internet gateway to this subnet allowing public traffic
resource "aws_internet_gateway" "test-env-gw" {
  vpc_id = "${aws_vpc.test-env.id}"
  
  tags = {
    Name = "test-env-gw"
  }
}