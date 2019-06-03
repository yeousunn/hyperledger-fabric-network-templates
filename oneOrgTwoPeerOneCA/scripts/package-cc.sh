PARENT_PATH=$(dirname $PWD)

if [ -z "$1" ]
then
    LANGUAGE="node"
else
    LANGUAGE=$1
fi
CC_POST="cc"

export CC_NAME="$LANGUAGE$CC_POST"
export CC_PATH="$PARENT_PATH/chaincode/$LANGUAGE"
export CC_VERSION="1.0"
export CC_CHANNEL_ID="org1channel"
ORDERER_ADDRESS="0.0.0.0:7050"

export FABRIC_CFG_PATH=$PARENT_PATH/peer
export CORE_PEER_MSPCONFIGPATH=$PARENT_PATH/fabric-ca/client/org1/admin/msp
export CORE_PEER_LOCALMSPID=Org1MSP

peer chaincode package ../artifacts/ccpack.out -n $CC_NAME -v $CC_VERSION -l node -p $CC_PATH