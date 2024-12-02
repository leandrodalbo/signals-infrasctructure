resource "aws_ecs_cluster" "crypto_trading_signals_cluster" {
  name = "${var.env}-${var.cluster_name}"
}




resource "aws_iam_role" "ecs_cluster_role" {
  name               = "${aws_ecs_cluster.crypto_trading_signals_cluster.name}-rl"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
          "Service": [
            "ecs.amazonaws.com",
            "ec2.amazonaws.com",
            "application-autoscaling.amazonaws.com"
          ]
      },
      "Action": "sts:AssumeRole"
    }
  ] 
}
EOF
}

resource "aws_iam_role_policy" "ecs_cluster_policy" {
  name   = "${aws_ecs_cluster.crypto_trading_signals_cluster.name}-pol"
  role   = aws_iam_role.ecs_cluster_role.id
  policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ecs:*",
          "ec2:*",
          "elasticloadbalancing:*",
          "ecr:*",
          "rds:*",
          "sqs:*",
          "sns:*",
          "ssm:*",
          "s3:*",
          "mq:*",
          "cloudwatch:*",
          "logs:*"
        ],
        "Resource":"*"
      }
    ] 
  }
  EOF
}