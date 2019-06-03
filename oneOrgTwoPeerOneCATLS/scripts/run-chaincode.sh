#!/bin/bash

PARENT_PATH=$(dirname $PWD)

function    usage {
    echo  "Usage: ./run-chaincode.sh    <install | instantiate | invoke | query> <node | go | java>"
    echo  "Utility for testing peer/channel setup with chaincode"
}

export FABRIC_LOGGING_SPEC=info
COMMAND=$1

if [ -z "$2" ]
then
    LANGUAGE="node"
else
    LANGUAGE=$2
fi

CC_POST="cc"

export CC_ARGS='{"Args":["init","a","100","b","200"]}'
export CC_NAME="$LANGUAGE$CC_POST"

export CC_PATH="$PARENT_PATH/chaincode/$LANGUAGE"
export CC_VERSION="1.0"
export CC_CHANNEL_ID="org1channel"

export CORE_PEER_MSPCONFIGPATH=$PARENT_PATH/fabric-ca/client/org1/admin/msp
export CORE_PEER_LOCALMSPID=Org1MSP
export FABRIC_CFG_PATH=$PARENT_PATH/peer

export CORE_PEER_ADDRESS=0.0.0.0:7051
ORDERER_ADDRESS=0.0.0.0:7050

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_TLS_ROOTCERT_FILE=$PARENT_PATH/fabric-ca/client/org1/tls-msp/tlscacerts/tls-0-0-0-0-7054.pem



case $COMMAND in
    "install")            
            peer chaincode install  -n $CC_NAME -p $CC_PATH -v $CC_VERSION -l node --tls --cafile $PARENT_PATH/fabric-ca/client/orderer/tls-msp/tlscacerts/tls-0-0-0-0-7054.pem

            peer chaincode list --installed -C $CC_CHANNEL_ID
        ;;
    "instantiate")
            peer chaincode instantiate -C $CC_CHANNEL_ID -n $CC_NAME  -v $CC_VERSION -c $CC_ARGS  -o $ORDERER_ADDRESS --tls --cafile $PARENT_PATH/fabric-ca/client/orderer/tls-msp/tlscacerts/tls-0-0-0-0-7054.pem
        ;;
    "query")
            echo -n "a= "
            peer chaincode query -C $CC_CHANNEL_ID -n $CC_NAME  -c '{"Args":["query","a"]}'
            echo -n "b= "
            peer chaincode query -C $CC_CHANNEL_ID -n $CC_NAME  -c '{"Args":["query","b"]}'
        ;;
    "invoke")
            peer chaincode invoke -C $CC_CHANNEL_ID -n $CC_NAME  -c '{"Args":["invoke","a","b","5"]}' --tls --cafile $PARENT_PATH/fabric-ca/client/orderer/tls-msp/tlscacerts/tls-0-0-0-0-7054.pem
        ;;
    *) usage
        ;;
esac