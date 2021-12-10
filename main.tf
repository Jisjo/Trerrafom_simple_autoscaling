


resource "aws_launch_configuration" "lb-lc" {
  name_prefix   = "${var.project}-lc"
  image_id      = "ami-052cef05d01020f1d"
  instance_type = "t2.micro"
  key_name      = "mumbai_webserver"
  user_data     = file("setup.sh")
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "asg" {
  name                 = "${var.project}-ag"
  launch_configuration = aws_launch_configuration.lb-lc.name
  availability_zones      =  ["ap-south-1a" , "ap-south-1b"]
  min_size             = "2"
  max_size             = "2"
  desired_capacity      = "2"
  

  health_check_type    = "EC2"
  health_check_grace_period = "160"
 
  #load_balancers          = [ "myapp" ]
  tag {
    key = "Name"
    propagate_at_launch = true
    value = "myapp"
  }
  lifecycle {
    create_before_destroy = true
  }

  
}