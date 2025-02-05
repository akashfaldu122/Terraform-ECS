resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = [ "subnet-03e9d0c5e7e44f035", "subnet-07dc9ecb3e126cb7c", "subnet-00e503c0502f18a10" ]
 }

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"
  

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ip-example.arn
  }
}


resource "aws_lb_target_group" "ip-example" {
  name        = "tf-example-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "vpc-0dadb72b0cd97b083"
}

output "lb_dns" {
 value = aws_lb.test.dns_name
}