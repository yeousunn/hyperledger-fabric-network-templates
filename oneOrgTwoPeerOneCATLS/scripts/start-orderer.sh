#!/bin/bash

# Set project parent path
PARENT_PATH=$(dirname $PWD)

# Path to configtx.yaml
export FABRIC_CFG_PATH=$PARENT_PATH/config

# Generate Genesis block
configtxgen -profile Org1OrdererGenesis -outputBlock ../artifacts/genesis.block -channelID ordererchannel

# Generate channel transaction
configtxgen -profile Org1Channel -outputCreateChannelTx ../artifacts/channel.tx -channelID org1channel

# Set logging specs
export FABRIC_LOGGING_SPEC=INFO

# Path to orderer.yaml
export FABRIC_CFG_PATH=$PARENT_PATH/orderer

# Set ledger location
export ORDERER_FILELEDGER_LOCATION=$PARENT_PATH/orderer/ledger


export ORDERER_GENERAL_LISTENADDRESS=0.0.0.0
export ORDERER_GENERAL_GENESISMETHOD=file
export ORDERER_GENERAL_GENESISFILE=$PARENT_PATH/artifacts/genesis.block
export ORDERER_GENERAL_LOCALMSPID=OrdererMSP
export ORDERER_GENERAL_LOCALMSPDIR=$PARENT_PATH/fabric-ca/client/orderer/orderer/msp

export ORDERER_GENERAL_TLS_ENABLED=true

# Set path to TLS MSP
export ORDERER_GENERAL_TLS_CERTIFICATE=$PARENT_PATH/fabric-ca/client/orderer/tls-msp/signcerts/cert.pem
export ORDERER_GENERAL_TLS_ROOTCAS=$PARENT_PATH/fabric-ca/client/orderer/tls-msp/tlscacerts/tls-0-0-0-0-7054.pem

# Rename the private key to key.pem (The one generated when specifying csr host)
# Private Key.
export ORDERER_GENERAL_TLS_PRIVATEKEY=$PARENT_PATH/fabric-ca/client/orderer/tls-msp/keystore/key.pem



# Start the Orderer
orderer  2> ../logs/orderer.log &