PARENT_PATH=$(dirname $PWD)


if [ -z "$1" ]
then
    LANGUAGE="node"
else
    LANGUAGE=$1
fi
CC_POST="cc"



#####################################
# ENROLL org1-peer2
#####################################
export FABRIC_CA_CLIENT_HOME=$PARENT_PATH/fabric-ca/client/org1/admin

ADMIN_CLIENT_HOME=$FABRIC_CA_CLIENT_HOME

export FABRIC_CA_CLIENT_HOME=$PARENT_PATH/fabric-ca/client/org1/org1-peer2

fabric-ca-client enroll -u http://org1-peer2:pw@0.0.0.0:7054

mkdir -p $FABRIC_CA_CLIENT_HOME/msp/admincerts

cp $ADMIN_CLIENT_HOME/msp/signcerts/*    $FABRIC_CA_CLIENT_HOME/msp/admincerts

sleep 3s
#####################################
# START org1-peer2
#####################################

PEER_NAME=org1-peer2

export FABRIC_LOGGING_SPEC=info

CRYPTO_CONFIG_ROOT_FOLDER=$PARENT_PATH/fabric-ca/client

export CORE_PEER_MSPCONFIGPATH=$PARENT_PATH/fabric-ca/client/org1/org1-peer2/msp

export CORE_PEER_LOCALMSPID=Org1MSP

export CORE_PEER_LISTENADDRESS=0.0.0.0:7051
export CORE_PEER_ADDRESS=0.0.0.0:7051

export CORE_PEER_CHAINCODELISTENADDRESS=0.0.0.0:7052

export CORE_PEER_EVENTS_ADDRESS=0.0.0.0:7053

export FABRIC_CFG_PATH=$PARENT_PATH/peer

export CURRENT_ORG_NAME=org1

export CURRENT_IDENTITY=org1-peer2

export CORE_PEER_FILESYSTEMPATH=$PARENT_PATH/peer/org1-peer2/ledger

mkdir -p $CORE_PEER_FILESYSTEMPATH

export CORE_PEER_ID=org1-peer2

peer node start 2> ../logs/org1-peer2.log &


sleep 5s

# Join Channel

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

export CORE_PEER_FILESYSTEMPATH=$PARENT_PATH/peer/org1-peer2/ledger

export CORE_PEER_ID=admin

ORDERER_ADDRESS=0.0.0.0:7050
CHANNEL_NAME=org1channel
GENESIS_BLOCK=org1channel-genesis.block

export CC_ARGS='{"Args":["init","a","100","b","200"]}'
export CC_NAME="$LANGUAGE$CC_POST"
export CC_PATH="$PARENT_PATH/chaincode/$LANGUAGE"
export CC_VERSION="1.0"

peer channel fetch config $GENESIS_BLOCK -o $ORDERER_ADDRESS -c $CHANNEL_NAME

peer channel join -o $ORDERER_ADDRESS -b $GENESIS_BLOCK

peer chaincode install ../artifacts/ccpack.out

peer chaincode list --installed -C $CHANNEL_NAME

peer chaincode upgrade -o $ORDERER_ADDRESS -C $CHANNEL_NAME -n $CC_NAME -v $CC_VERSION -c $CC_ARGS
