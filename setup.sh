#!/bin/bash

if [ -z "$PAT" ]; then
	echo "Enter Azure Personal Access Token (PAT): "
	read PAT
fi

echo "Enter Pool Name:"
read POOL_NAME

echo "Enter Agent Name:"
read AGENT_NAME

mkdir -p agent
echo "Downloading Azure Linux Agent for ARM64"
wget https://vstsagentpackage.azureedge.net/agent/2.172.2/vsts-agent-linux-arm64-2.172.2.tar.gz -O vsts-agent.tar.gz -c
echo "Extracting agent"
tar zxvf vsts-agent.tar.gz -C ./agent/
echo "Removing compressed file"

cd agent
./config.sh --unattended --url https://dev.azure.com/emwjacobson --auth pat --token $PAT --pool $POOL_NAME --agent $AGENT_NAME-$RANDOM --acceptTeeEula 
cd ..
ln -s ./agent/run.sh run.sh
ln -s ./agent/svc.sh svc.sh
./run.sh