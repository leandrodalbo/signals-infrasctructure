resource "aws_iam_role" "cluster_role" {
  name               = "${var.env}-${var.appname}-cluster-rl"
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
            "ecs-tasks.amazonaws.com",
            "application-autoscaling.amazonaws.com"
          ]
      },
      "Action": "sts:AssumeRole"
    }
  ] 
}
EOF
}

resource "aws_iam_role_policy" "cluster_role_policy" {
  name   = "${var.env}-${var.appname}-cluster-pol"
  role   = aws_iam_role.cluster_role.id
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
          "cloudwatch:*",
          "ecr:*",
          "rds:*",
          "sns:*",
          "ssm:*",
          "sqs:*",
          "logs:*",
          "s3:*"
        ],
        "Resource":"*"
      }
    ] 
  }
  EOF
}


resource "aws_iam_role" "lambda_role" {
  name               = "${var.env}-lambda-rl"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
          "Service": [
            "lambda.amazonaws.com"
          ]
      },
      "Action": "sts:AssumeRole"
    }
  ] 
}
EOF
}

resource "aws_iam_role_policy" "lambda_role_policy" {
  name   = "${var.env}-pol"
  role   = aws_iam_role.lambda_role.id
  policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "cloudwatch:*",
          "rds:*",
          "sns:*",
          "ssm:*",
          "logs:*",
          "s3:*",
          "ec2:*"
        ],
        "Resource":"*"
      }
    ] 
  }
  EOF
}