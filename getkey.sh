#!/bin/bash
KEY_FILE="${1}.pem"

terraform output -raw private_key > "$KEY_FILE"
chmod 400 "$KEY_FILE"
