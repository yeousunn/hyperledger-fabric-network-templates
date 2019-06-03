# This will start the fabric network.

#####################################################
# With TLS enabled, there are files that needs to be 
# renamed before starting the network.
# So, it is better to run one script at a time.
# Just follow the sequence below.
#####################################################

# ./start-ca-server.sh


# ./setup-network-admins.sh


# ./setup-msp.sh


# ./setup-identities.sh


################################################################
# Rename private key of orderer and org1 organization tls-msp
#
# fabric-ca/client/orderer/tls-msp/keystore/<hex>_sk to key.pem
# and
# fabric-ca/client/org1/tls-msp/keystore/<hex>_sk to key.pem
#
################################################################

# ./start-orderer.sh
 

# ./start-peer.sh


# ./join-channel.sh


# ./run-chaincode.sh install


# ./run-chaincode.sh instantiate

echo "Run all scripts manually."