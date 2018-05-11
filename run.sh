#!/usr/bin/env bash

export AWS_REGION=us-east-1
terraform $1 -var-file ./config.tfvars
