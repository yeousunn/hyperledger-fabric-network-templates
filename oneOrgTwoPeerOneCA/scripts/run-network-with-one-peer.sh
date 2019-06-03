# This will start the fabric network.
./start-ca-server.sh

sleep 3s

./setup-network-admins.sh

sleep 3s

./setup-msp.sh

sleep 3s

./setup-identities.sh

sleep 3s

./start-orderer.sh

sleep 6s

./start-peer.sh

sleep 3s

./join-channel.sh

sleep 3s

./run-chaincode.sh install

sleep 3s

./run-chaincode.sh instantiate