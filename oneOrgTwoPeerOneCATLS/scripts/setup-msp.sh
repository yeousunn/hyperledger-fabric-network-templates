#!/bin/bash

# Set project parent path
PARENT_PATH=$(dirname $PWD)

#######################################
# Orderer Organization MSP
#######################################
# Set Environment
export FABRIC_CA_SERVER_HOME=$PARENT_PATH/fabric-ca/server
export FABRIC_CA_CLIENT_HOME=$PARENT_PATH/fabric-ca/client/orderer/admin

# Path to the CA certificate
ROOT_CA_CERTIFICATE=$FABRIC_CA_SERVER_HOME/ca-cert.pem

# Path to TLS CA certificate
# 
# IMPORTANT!!!
# For this template there is only one CA, so TLS CA is the same CA server
ROOT_TLS_CA_CERTIFICATE=$FABRIC_CA_SERVER_HOME/ca-cert.pem

# Parent folder for the MSP folder
DESTINATION_CLIENT_HOME="$PARENT_PATH/fabric-ca/client/orderer"

# Create the required MSP subfolders
mkdir -p $DESTINATION_CLIENT_HOME/msp/admincerts 
mkdir -p $DESTINATION_CLIENT_HOME/msp/cacerts 
mkdir -p $DESTINATION_CLIENT_HOME/msp/keystore
mkdir -p $DESTINATION_CLIENT_HOME/msp/tlscacerts

# Copy the Root CA Cert
cp $ROOT_CA_CERTIFICATE $DESTINATION_CLIENT_HOME/msp/cacerts/

# Copy the TLS CA Cert
cp $ROOT_TLS_CA_CERTIFICATE $DESTINATION_CLIENT_HOME/msp/tlscacerts/tls-ca-cert.pem


# Copy the admin certs - Org admin is the admin for the specified Org
cp $FABRIC_CA_CLIENT_HOME/msp/signcerts/* $DESTINATION_CLIENT_HOME/msp/admincerts/



#######################################
# Org1 Organization MSP
#######################################
# Set Environment
export FABRIC_CA_SERVER_HOME=$PARENT_PATH/fabric-ca/server
export FABRIC_CA_CLIENT_HOME=$PARENT_PATH/fabric-ca/client/org1/admin

# Path to the CA certificate
ROOT_CA_CERTIFICATE=$FABRIC_CA_SERVER_HOME/ca-cert.pem

# Path to TLS CA certificate
ROOT_TLS_CA_CERTIFICATE=$FABRIC_CA_SERVER_HOME/ca-cert.pem

# Parent folder for the MSP folder
DESTINATION_CLIENT_HOME="$PARENT_PATH/fabric-ca/client/org1"

# Create the required MSP subfolders
mkdir -p $DESTINATION_CLIENT_HOME/msp/admincerts 
mkdir -p $DESTINATION_CLIENT_HOME/msp/cacerts 
mkdir -p $DESTINATION_CLIENT_HOME/msp/keystore
mkdir -p $DESTINATION_CLIENT_HOME/msp/tlscacerts

# Copy the Root CA Cert
cp $ROOT_CA_CERTIFICATE $DESTINATION_CLIENT_HOME/msp/cacerts/

# Copy the TLS CA Cert
cp $ROOT_TLS_CA_CERTIFICATE $DESTINATION_CLIENT_HOME/msp/tlscacerts/tls-ca-cert.pem

# Copy the admin certs - ORG admin is the admin for the specified Org
cp $FABRIC_CA_CLIENT_HOME/msp/signcerts/* $DESTINATION_CLIENT_HOME/msp/admincerts/