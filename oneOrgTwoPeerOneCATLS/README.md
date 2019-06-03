# oneOrgTwoPeerOneCATLS

Hyperledger Fabric Binary Version: 1.4.2

This Template starts Hyperledger Fabric network containing one orderer organization, one peer organization and one CA server.

TLS is enabled for this network.

Two peers will be added to the peer organization.

This template requires two systems. The scripts will start the network with one peer and chaincode installed.

## Note

    In scripts folder run the following command
        chmod 755 *.sh

    May require to change the IP/host in files
    i. configtx.yaml
        Orderer
          Addresses:
            - <IP/host>:7050

    ii. orderer.yaml
        ListenAddress: <IP/host>

    iii. start-peer.sh
        ORDERER_ADDRESS=<IP/host>:7050

    iv. setup-and-start-peer2.sh
        ORDERER_ADDRESS=<IP/host>:7050
        fabric-ca-client enroll -u http://org1-peer2:pw@<IP/CA-host>:7054

    v. run-chaincode.sh
        ORDERER_ADDRESS=<IP/host>:7050

    vi. package-cc.sh
        ORDERER_ADDRESS=<IP/host>:7050

    vii. join-channel.sh
        ORDERER_ADDRESS=<IP/host>:7050

## Steps

1; To Start the network, cd into scripts folder and run follow the instructions given in this script file:

    ./run-network-with-one-peer.sh

The above file list all the script's in sequence they are needed to run.

2; Before starting second peer, create chaincode package by running the following script:

    ./package-cc.sh

3; On Second peer, copy the required crypto materials from the first node.
    i. MSP of organization
    ii. Copy chaincode package, ccpack.out to scripts folder.

4; On second peer run the following scripts

   ./setup-and-start-peer2.sh
