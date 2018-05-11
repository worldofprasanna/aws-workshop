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
            "Sid": "Stmt1506085059000",
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "Stmt1506085059002",
            "Effect": "Allow",
            "Action": [
                "logs:*"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "Stmt1506085059100",
            "Effect": "Allow",
            "Action": [
                "events:*"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "Stmt1506085082000",
            "Effect": "Allow",
            "Action": [
                "lambda:*"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "Stmt1506085082100",
            "Effect": "Allow",
            "Action": [
                "cloudwatch:*"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "Stmt1506085082010",
            "Effect": "Allow",
            "Action": [
                "cloudfront:*"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "Stmt1506085082001",
            "Effect": "Allow",
            "Action": [
                "dynamodb:*"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "Stmt1506085105001",
            "Effect": "Allow",
            "Action": [
                "apigateway:*"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "Stmt1506085122002",
            "Effect": "Allow",
            "Action": [
                "rds:*"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "Stmt1506085122003",
            "Effect": "Allow",
            "Action": [
                "kms:*"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "Stmt1506085139003",
            "Effect": "Allow",
            "Action": [
                "cognito-identity:*",
                "cognito-idp:*",
                "cognito-sync:*",
                "iam:ListRoles",
                "iam:ListOpenIdConnectProviders",
                "sns:ListPlatformApplications"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "Stmt1506085159004",
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:*"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "Stmt1506085188005",
            "Effect": "Allow",
            "Action": [
                "iam:*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}POLICY

}

resource "aws_iam_user_login_profile" "login_profile" {
  count = "${length(var.attendees)}"
  user    = "${element(aws_iam_user.users.*.name, count.index)}"
  pgp_key = "${file("keybase_public_key.txt")}"
}

output "password" {
  value    = "${aws_iam_user_login_profile.login_profile.*.encrypted_password}"
}

output "username" {
  value    = "${aws_iam_user.users.*.name}"
}
