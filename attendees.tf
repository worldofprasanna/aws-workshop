resource "aws_iam_user" "users" {
  count = "${length(var.attendees)}"
  name = "workshop-${element(var.attendees, count.index)}"
}

resource "aws_iam_access_key" "tenant_users_access_key" {
  count = "${length(var.attendees)}"
  user = "${element(aws_iam_user.users.*.name, count.index)}"
}

resource "aws_iam_user_policy" "tenant_user_policy" {
  count = "${length(var.attendees)}"
  name = "aws-workshop-access"
  user = "${element(aws_iam_user.users.*.name, count.index)}"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
       {
            "Sid": "Stmt1496641315000",
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
              *
            ]
        }
    ]
}POLICY
}


