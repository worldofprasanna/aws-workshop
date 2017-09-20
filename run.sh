#!/usr/bin/env bash

terraform $1 -var-file ./config.tfvars
