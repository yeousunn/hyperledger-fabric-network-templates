#!/bin/bash

# Stop all processes

killall fabric-ca-server 2> /dev/null
killall peer 2> /dev/null
killall orderer 2> /dev/null

# Remove all CA server artifacts
rm -rf ../fabric-ca/server/* 2> /dev/null

# Remove all client artifacts
rm -rf ../fabric-ca/client/* 2> /dev/null

# Remove all logs
rm -rf ../logs/* 2> /dev/null

# Remove all artifacts
rm -rf ../artifacts/* 2> /dev/null
rm ../peer/*.block 2> /dev/null
rm *.block 2> /dev/null

# Remove all ledger 
rm -rf ../orderer/ledger/* 2> /dev/null
rm -rf ../peer/org1-peer1/ledger/* 2> /dev/null

# Remove all docker container/images
docker rm $(docker ps -aq)
docker rmi $(docker images -q)