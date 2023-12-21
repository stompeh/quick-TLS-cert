#!/usr/bin/env bash

mkdir certs
cd certs

echo "Generating RSA ca-key.pem"
# add -aes256 after genrsa to include a password
openssl genrsa -out ca-key.pem 4096
echo "Generating x509 ca.pem"
openssl req -new -x509 -sha256 -days 365 -key ca-key.pem -out ca.pem

echo "Generating cert.csr [private]"
openssl genrsa -out cert-key.pem 4096
openssl req -new -sha256 -subj "/CN=Somename" -key cert-key.pem -out cert.csr

# Use a hostname or IP.
# DNS:<hostname>
# IP:<ipaddress>
# Can use multiple lines:
# echo "subjectAltName=DNS:doop.myserver.com" >> extfile.cnf
# echo "subjectAltName=DNS:files.myserver.com" >> extfile.cnf
# echo "subjectAltName=IP:10.10.15.15" >> extfile.cnf
echo "subjectAltName=IP:10.8.0.175" >> extfile.cnf

echo "Generating SSL/TLS cert:"
echo "cert.pem [public]"
echo "Signing with cert.csr [private]"
openssl x509 -req -sha256 -days 365 -in cert.csr -CA ca.pem -CAkey ca-key.pem -out cert.pem -extfile extfile.cnf -CAcreateserial


#On Debian & Derivatives
echo "Move the CA certificate (ca.pem) into /usr/local/share/ca-certificates/ca.crt\n"
echo "Update the Cert Store with:\n"
echo "sudo update-ca-certificates\n"
