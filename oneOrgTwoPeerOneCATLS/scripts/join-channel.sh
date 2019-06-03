PARENT_PATH=$(dirname $PWD)

PEER_NAME=admin

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

export CORE_PEER_FILESYSTEMPATH=$PARENT_PATH/peer/org1-peer1/ledger

export CORE_PEER_ID=admin

ORDERER_ADDRESS=0.0.0.0:7050
CHANNEL_NAME=org1channel
GENESIS_BLOCK=org1channel-genesis.block

# Fetch the channel genesis block
peer channel fetch config $GENESIS_BLOCK -o $ORDERER_ADDRESS -c $CHANNEL_NAME --tls --cafile $PARENT_PATH/fabric-ca/client/orderer/tls-msp/tlscacerts/tls-0-0-0-0-7054.pem


# Enable TLS
export CORE_PEER_TLS_ENABLED=true

export CORE_PEER_TLS_ROOTCERT_FILE=$PARENT_PATH/fabric-ca/client/org1/tls-msp/tlscacerts/tls-0-0-0-0-7054.pem

export CORE_PEER_TLS_CERT_FILE=$PARENT_PATH/fabric-ca/client/org1/tls-msp/signcerts/cert.pem

export CORE_PEER_TLS_KEY_FILE=$PARENT_PATH/fabric-ca/client/org1/tls-msp/keystore/key.pem

# join the channel
peer channel join -o $ORDERER_ADDRESS -b $GENESIS_BLOCK --tls --cafile $PARENT_PATH/fabric-ca/client/orderer/tls-msp/tlscacerts/tls-0-0-0-0-7054.pem