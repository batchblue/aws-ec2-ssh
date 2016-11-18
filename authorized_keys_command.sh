#!/bin/bash -e

if [ -z "$1" ]; then
  exit 1
fi

/usr/local/bin/aws iam list-ssh-public-keys --user-name "$1" --query "SSHPublicKeys[?Status == 'Active'].[SSHPublicKeyId]" --output text | while read KeyId; do
  /usr/local/bin/aws iam get-ssh-public-key --user-name "$1" --ssh-public-key-id "$KeyId" --encoding SSH --query "SSHPublicKey.SSHPublicKeyBody" --output text
done
