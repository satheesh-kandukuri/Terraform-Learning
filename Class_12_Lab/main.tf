resource "aws_iam_role" "TF_role" {
  name = "TF_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

/*
why you need assume role policy is required?

When you create an IAM role, AWS must know what service or principal is allowed to assume (use) the role.

    This is handled through the assume_role_policy (a trust relationship).

    It’s not about what the role can do, but who can use the role.
*/

resource "aws_iam_role_policy_attachment" "Policy_attach" {
  role       = aws_iam_role.TF_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"

}

resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = aws_iam_role.TF_role.name
}

resource "aws_instance" "test-vm-01" {
  ami                  = "ami-054b7fc3c333ac6d2"
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.test_profile.name

  tags = {
    Name = "test-vm-01"
  }
}
