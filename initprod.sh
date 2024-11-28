#!/bin/sh

terraform init -backend-config="key=$KEY" -backend-config="bucket=$BUCKET" -backend-config="region=$REGION"
