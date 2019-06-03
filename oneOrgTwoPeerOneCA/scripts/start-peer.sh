#!/bin/bash

# Set project parent path
PARENT_PATH=$(dirname $PWD)

# Set Environment
export FABRIC_LOGGING_SPEC=info

CRYPTO_CONFIG_ROOT_FOLDER=$PARENT_PATH/fabric-ca/client

export CORE_PEER_MSPCONFIGPATH=$PARENT_PATH/fabric-ca/client/org1/admin/msp

export CORE_PEER_LOCALMSPID=Org1MSP

export CORE_PEER_LISTENADDRESS=0.0.0.0:7051
export CORE_PEER_ADDRESS=0.0.0.0:7051

export CORE_PEER_CHAINCODELISTENADDRESS=0.0.0.0:7052

export CORE_PEER_EVENTS_ADDRESS=0.0.0.0:7053

export FABRIC_CFG_PATH=$PARENT_PATH/peer

export CURRENT_ORG_NAME=org1

export CURRENT_IDENTITY=admin


#####################################
# Create Channel
#####################################
CHANNEL_NAME=org1channel

CHANNEL_TX_FILE=$PARENT_PATH/artifacts/channel.tx

ORDERER_ADDRESS=0.0.0.0:7050

peer channel create -o $ORDERER_ADDRESS -c $CHANNEL_NAME -f $CHANNEL_TX_FILE --outputBlock $PARENT_PATH/peer/$CHANNEL_NAME-genesis.block


#####################################
# Start Peer
#####################################
# Set Environment to launch peer
PEER_NAME=org1-peer1

export CORE_PEER_MSPCONFIGPATH=$PARENT_PATH/fabric-ca/client/org1/org1-peer1/msp

export CURRENT_IDENTITY=org1-peer1

export CORE_PEER_FILESYSTEMPATH=$PARENT_PATH/peer/org1-peer1/ledger

mkdir -p $CORE_PEER_FILESYSTEMPATH

export CORE_PEER_ID=org1-peer1

peer node start 2> ../logs/org1-peer1.log &