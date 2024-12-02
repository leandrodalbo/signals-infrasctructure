#!/bin/sh

terraform init -backend-config="key=$TF_ESTATE_KEY" -backend-config="bucket=$TF_ESTATE_BUCKET" -backend-config="region=$TF_region"
