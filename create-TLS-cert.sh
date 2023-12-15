#!/bin/bash

mkdir certs
cd certs

echo "Generating AES ca-key\n"
# To use a password:
# openssl genrsa -aes256 -out ca-key.pem 4096
openssl genrsa -out ca-key.pem 4096
openssl req -new -x509 -sha256 -days 365 -key ca-key.pem -out ca.pem

echo "Generating cert-key\n"
openssl genrsa -out cert-key.pem 4096
openssl req -new -sha256 -subj "/CN=SomeName" -key cert-key.pem -out cert.csr

# Use a hostname or IP.
# DNS:<hostname>
# IP:<ipaddress>
# Can use multiple lines:
# echo "subjectAltName=DNS:doop.myserver.com" >> extfile.cnf
# echo "subjectAltName=DNS:files.myserver.com" >> extfile.cnf
# echo "subjectAltName=IP:10.10.15.15" >> extfile.cnf
echo "subjectAltName=DNS:localhost" >> extfile.cnf

openssl x509 -req -sha256 -days 365 -in cert.csr -CA ca.pem -CAkey ca-key.pem -out cert.pem -extfile extfile.cnf -CAcreateserial


#On Debian
#Move the CA certificate (ca.pem) into /usr/local/share/ca-certificates/ca.crt.
#Update the Cert Store with:
#sudo update-ca-certificates
