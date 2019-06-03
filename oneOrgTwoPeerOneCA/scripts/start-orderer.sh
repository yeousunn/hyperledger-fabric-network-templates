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

# Start the Orderer
orderer  2> ../logs/orderer.log &