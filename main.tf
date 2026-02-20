# -------------------------
# Key Pair
# -------------------------

resource "aws_key_pair" "habit_quest_key" {

  key_name   = "habit-quest-key"
  public_key = file("habit_quest_key.pub")

  tags = {
    Name    = "habit-quest-key"
    Project = "habit-quest"
  }

}

# -------------------------
# Default VPC
# -------------------------

resource "aws_default_vpc" "default" {}

# -------------------------
# Security Group
# -------------------------

resource "aws_security_group" "habit_quest_sg" {

  name        = "habit-quest-sg"
  description = "Security group for Habit Quest"
  vpc_id      = aws_default_vpc.default.id


  # SSH access

  ingress {

    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }


  # HTTP access

  ingress {

    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }


  # outbound

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }


  tags = {

    Name    = "habit-quest-sg"
    Project = "habit-quest"

  }

}


# -------------------------
# EC2 Instance
# -------------------------

resource "aws_instance" "habit_quest_instance" {

  ami           = var.ami_id
  instance_type = var.instance_type

  key_name = aws_key_pair.habit_quest_key.key_name

  vpc_security_group_ids = [
    aws_security_group.habit_quest_sg.id
  ]


  root_block_device {

    volume_size = var.ec2_root_storage_size
    volume_type = "gp3"

  }

  user_data = file("user_data.sh")

  tags = {

    Name    = "habit-quest-instance"
    Project = "habit-quest"

  }

}
