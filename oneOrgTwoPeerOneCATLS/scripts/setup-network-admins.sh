#!/bin/bash


#######################################
#  REGISTER NETWORK ADMINS
#######################################
# Set project parent path
PARENT_PATH=$(dirname $PWD)

# Set TLS CA-CERT FILE
export FABRIC_CA_CLIENT_TLS_CERTFILES=$PARENT_PATH/fabric-ca/server/ca-cert.pem

# Set CA Server admin home
export FABRIC_CA_CLIENT_HOME=$PARENT_PATH/fabric-ca/client/caserver/admin

# Register orderer-admin
ATTRIBUTES='"hf.Registrar.Roles=orderer,user,client"'

fabric-ca-client register --id.type client --id.name orderer-admin --id.secret pw --id.affiliation orderer --id.attrs $ATTRIBUTES -u https://0.0.0.0:7054

# Register org1-admin
ATTRIBUTES='"hf.Registrar.Roles=peer,user,client","hf.AffiliationMgr=true","hf.Revoker=true"'

fabric-ca-client register --id.type client --id.name org1-admin --id.secret pw --id.affiliation org1 --id.attrs $ATTRIBUTES -u https://0.0.0.0:7054


sleep 3s
#######################################
#  ENROLL NETWORK ADMINS
#######################################
# Enroll orderer admin

# Set TLS CA-CERT FILE
export FABRIC_CA_CLIENT_TLS_CERTFILES=$PARENT_PATH/fabric-ca/server/ca-cert.pem

export FABRIC_CA_CLIENT_HOME=$PARENT_PATH/fabric-ca/client/orderer/admin

fabric-ca-client enroll -u https://orderer-admin:pw@0.0.0.0:7054

# Setup the MSP for the orderer-admin
mkdir $PARENT_PATH/fabric-ca/client/orderer/admin/msp/admincerts
cp $PARENT_PATH/fabric-ca/client/caserver/admin/msp/signcerts/* $PARENT_PATH/fabric-ca/client/orderer/admin/msp/admincerts/


# Enroll org1-admin

# Set TLS CA-CERT FILE
export FABRIC_CA_CLIENT_TLS_CERTFILES=$PARENT_PATH/fabric-ca/server/ca-cert.pem

export FABRIC_CA_CLIENT_HOME=$PARENT_PATH/fabric-ca/client/org1/admin

fabric-ca-client enroll -u https://org1-admin:pw@0.0.0.0:7054

# Setup the MSP for the org1 admin 
mkdir $PARENT_PATH/fabric-ca/client/org1/admin/msp/admincerts
cp $PARENT_PATH/fabric-ca/client/caserver/admin/msp/signcerts/* $PARENT_PATH/fabric-ca/client/org1/admin/msp/admincerts/