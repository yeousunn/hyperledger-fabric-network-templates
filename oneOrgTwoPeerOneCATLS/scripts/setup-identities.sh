#!/bin/bash

# Set project parent path
PARENT_PATH=$(dirname $PWD)

#######################################
# Generates the Orderer identity
#######################################

# Set TLS CA-CERT FILE
export FABRIC_CA_CLIENT_TLS_CERTFILES=$PARENT_PATH/fabric-ca/server/ca-cert.pem

# Set the Identity context to Orderer Admin
export FABRIC_CA_CLIENT_HOME=$PARENT_PATH/fabric-ca/client/orderer/admin

# Register the orderer identity
AFFILIATION=orderer
fabric-ca-client register --id.type orderer --id.name orderer --id.secret pw --id.affiliation $AFFILIATION

# Set the admin MSP localtion in a variable
ADMIN_CLIENT_HOME=$FABRIC_CA_CLIENT_HOME

# Change the client context to orderer identity
export FABRIC_CA_CLIENT_HOME=$PARENT_PATH/fabric-ca/client/orderer/orderer

# Enrolled Orderer identity
fabric-ca-client enroll -u https://orderer:pw@0.0.0.0:7054 


sleep 3s
# IMPORTANT!!!
#
# This generates certificates for orderer using TLS server.
export FABRIC_CA_CLIENT_MSPDIR=$PARENT_PATH/fabric-ca/client/orderer/tls-msp

# PATH TO TLS ca-cert.pem file (In this case it is same as CA Server)
export FABRIC_CA_CLIENT_TLS_CERTFILES=$PARENT_PATH/fabric-ca/server/ca-cert.pem

fabric-ca-client enroll -u https://orderer:pw@0.0.0.0:7054 --enrollment.profile tls --csr.hosts 0.0.0.0

# Copy the admincerts to the appropriate folder
mkdir -p $FABRIC_CA_CLIENT_HOME/msp/admincerts
cp $ADMIN_CLIENT_HOME/msp/signcerts/* $FABRIC_CA_CLIENT_HOME/msp/admincerts/


sleep 3s
#######################################
# Generates the Peer identity
#######################################

unset AFFILIATION
unset ADMIN_CLIENT_HOME
unset FABRIC_CA_CLIENT_HOME
unset FABRIC_CA_CLIENT_MSPDIR
unset FABRIC_CA_CLIENT_TLS_CERTFILES


export FABRIC_CA_CLIENT_TLS_CERTFILES=$PARENT_PATH/fabric-ca/server/ca-cert.pem

# Set the Identity context to org1 Admin
export FABRIC_CA_CLIENT_HOME=$PARENT_PATH/fabric-ca/client/org1/admin

# Register the peer identity
AFFILIATION=org1
fabric-ca-client register --id.type peer --id.name org1-peer1 --id.secret pw --id.affiliation $AFFILIATION

fabric-ca-client register --id.type peer --id.name org1-peer2 --id.secret pw --id.affiliation $AFFILIATION


sleep 3s

# Set the admin MSP localtion in a variable
ADMIN_CLIENT_HOME=$FABRIC_CA_CLIENT_HOME

# Change the client context to peer identity
export FABRIC_CA_CLIENT_HOME=$PARENT_PATH/fabric-ca/client/org1/org1-peer1

# Enrolled Peer identity
fabric-ca-client enroll -u https://org1-peer1:pw@0.0.0.0:7054


sleep 3s
# IMPORTANT!!!
#
# This generates certificates for orderer using TLS server.
export FABRIC_CA_CLIENT_MSPDIR=$PARENT_PATH/fabric-ca/client/org1/tls-msp

# PATH TO TLS ca-cert.pem file (In this case it is same as CA Server)
export FABRIC_CA_CLIENT_TLS_CERTFILES=$PARENT_PATH/fabric-ca/server/ca-cert.pem

fabric-ca-client enroll -u https://org1-peer1:pw@0.0.0.0:7054 --enrollment.profile tls --csr.hosts 0.0.0.0

# Copy the admincerts to the appropriate folder
mkdir -p $FABRIC_CA_CLIENT_HOME/msp/admincerts
cp $ADMIN_CLIENT_HOME/msp/signcerts/*    $FABRIC_CA_CLIENT_HOME/msp/admincerts
