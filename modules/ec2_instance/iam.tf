resource "aws_iam_role" "codeDeploy_ec2_instance_profile_role" {
  name               = "CodeDeployDemo-EC2-Instance-Profile"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "TerraformCreated",
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codeDeploy_ec2_policy" {
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
EOF
  role = aws_iam_role.codeDeploy_ec2_instance_profile_role.id
  name = "CodeDeploy-EC2-Permissions"
}

resource "aws_iam_role_policy_attachment" "codeDeploy_ec2_instance_profile_role" {
  role       = aws_iam_role.codeDeploy_ec2_instance_profile_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "codedeploy_ec2_instance_profile" {
  name = "CodeDeploy-EC2-Instance-Profile"
  role = aws_iam_role.codeDeploy_ec2_instance_profile_role.name
}