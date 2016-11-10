#!/bin/bash
SSH_KEY_PATH="/Users/prokarma/.ssh/mcheriyath"
export SSH_KEY_PATH

AZURE_SSH_KEY_PATH="/tmp/azure-deployer.pfx"
export AZURE_SSH_KEY_PATH

openssl req -x509 \
  -key $SSH_KEY_PATH \
  -nodes \
  -days 365 -newkey rsa:2048 \
  -out /tmp/azure-deployer.pem \
  -subj '/CN=www.mcheriyath.com/O=MCheriyathCorp./C=US'
openssl x509 \
  -outform der \
  -in /tmp/azure-deployer.pem \
  -out $AZURE_SSH_KEY_PATH
THUMBPRINT=$(openssl x509 -fingerprint -inform der -in $AZURE_SSH_KEY_PATH | grep "SHA1 Fingerprint")
THUMBPRINT="${THUMBPRINT#*=}"
fingerprint="${THUMBPRINT//:/}"
AZURE_SSH_KEY_FINGERPRINT=$fingerprint

export AZURE_SSH_KEY_FINGERPRINT

