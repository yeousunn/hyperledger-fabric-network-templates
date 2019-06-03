#!/bin/bash

# Set project parent path
PARENT_PATH=$(dirname $PWD)

#######################################
# Generates the Orderer identity
#######################################

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
fabric-ca-client enroll -u http://orderer:pw@0.0.0.0:7054 

# Copy the admincerts to the appropriate folder
mkdir -p $FABRIC_CA_CLIENT_HOME/msp/admincerts
cp $ADMIN_CLIENT_HOME/msp/signcerts/* $FABRIC_CA_CLIENT_HOME/msp/admincerts/


#######################################
# Generates the Peer identity
#######################################
# Set the Identity context to org1 Admin
export FABRIC_CA_CLIENT_HOME=$PARENT_PATH/fabric-ca/client/org1/admin

# Register the peer identity
AFFILIATION=org1
fabric-ca-client register --id.type peer --id.name org1-peer1 --id.secret pw --id.affiliation $AFFILIATION

fabric-ca-client register --id.type peer --id.name org1-peer2 --id.secret pw --id.affiliation $AFFILIATION

# Set the admin MSP localtion in a variable
ADMIN_CLIENT_HOME=$FABRIC_CA_CLIENT_HOME

# Change the client context to peer identity
export FABRIC_CA_CLIENT_HOME=$PARENT_PATH/fabric-ca/client/org1/org1-peer1

# Enrolled Peer identity
fabric-ca-client enroll -u http://org1-peer1:pw@0.0.0.0:7054

# Copy the admincerts to the appropriate folder
mkdir -p $FABRIC_CA_CLIENT_HOME/msp/admincerts
cp $ADMIN_CLIENT_HOME/msp/signcerts/*    $FABRIC_CA_CLIENT_HOME/msp/admincerts
