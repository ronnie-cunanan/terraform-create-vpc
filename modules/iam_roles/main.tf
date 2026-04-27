# -------------------------
# IAM ROLE
# -------------------------
resource "aws_iam_role" "this" {
  for_each = var.roles

  name = "${each.key}-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "${each.key}-${var.environment}"
    Environment = var.environment
  }
}

# -------------------------
# INSTANCE PROFILE
# -------------------------
resource "aws_iam_instance_profile" "this" {
  for_each = var.roles

  name = "${each.key}-instance-profile-${var.environment}"
  role = aws_iam_role.this[each.key].name
}

# -------------------------
# POLICY ATTACHMENTS
# -------------------------
resource "aws_iam_role_policy_attachment" "attachments" {
  for_each = {
    for pair in flatten([
      for role_name, role_data in var.roles : [
        for policy_arn in role_data.policies : {
          role       = role_name
          policy_arn = policy_arn
          key        = "${role_name}-${replace(policy_arn, "/", "-")}" 
        }
      ]
    ]) : pair.key => pair
  }

  role       = aws_iam_role.this[each.value.role].name
  policy_arn = each.value.policy_arn
}
