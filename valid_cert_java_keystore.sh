#!/usr/bin/env bash

# https://hstechdocs.helpsystems.com/manuals/cobaltstrike/current/userguide/content/topics/malleable-c2_valid-ssl-certificates.htm#_Toc65482847

# Use the keytool program to create a Java Keystore file. 
# This program will ask “What is your first and last name?” Make sure you answer with the fully qualified domain name to your Beacon server. 
# Also, make sure you take note of the keystore password. You will need it later.
keytool -genkey -keyalg RSA -keysize 2048 -keystore domain.store

# Use keytool to generate a Certificate Signing Request (CSR).
# You will submit this file to your SSL certificate vendor.
# They will verify that you are who you are and issue a certificate.
# Some vendors are easier and cheaper to deal with than others.
keytool -certreq -keyalg RSA -file domain.csr -keystore domain.store

# Import the Root and any Intermediate Certificates that your SSL vendor provides.
keytool -import -trustcacerts -alias FILE -file FILE.crt -keystore domain.store

# Finally, you must install your Domain Certificate.
keytool -import -trustcacerts -alias mykey -file domain.crt -keystore domain.store
