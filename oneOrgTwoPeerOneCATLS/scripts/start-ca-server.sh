#!/bin/bash

#####################################################
# Edit config/fabric-ca-server-config.yaml as needed.
# Copy to fabric-ca/server/
#####################################################
cp $PWD/../config/fabric-ca-server-config.yaml $PWD/../fabric-ca/server/fabric-ca-server-config.yaml

# Set project parent path
PARENT_PATH=$(dirname $PWD)

# Set Server and Client home
export FABRIC_CA_SERVER_HOME=$PARENT_PATH/fabric-ca/server
export FABRIC_CA_CLIENT_HOME=$PARENT_PATH/fabric-ca/client

# Enable TLS
export FABRIC_CA_SERVER_CSR_HOSTS="0.0.0.0"
export FABRIC_CA_SERVER_TLS_ENABLED="true"
export FABRIC_CA_SERVER_CSR_CN="caserver"

# Initialize the CA Server 
fabric-ca-server init -b admin:adminpw -n caserver

sleep 3s

# Start the CA Server
fabric-ca-server start -n caserver &

sleep 5s

# Set CA Server admin home
export FABRIC_CA_CLIENT_HOME=$PARENT_PATH/fabric-ca/client/caserver/admin

# Set TLS CA-CERT FILE
export FABRIC_CA_CLIENT_TLS_CERTFILES=$PARENT_PATH/fabric-ca/server/ca-cert.pem

# Enroll the Bootstrap Admin
fabric-ca-client enroll -u https://admin:adminpw@0.0.0.0:7054