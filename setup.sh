#!/bin/bash

if [ -z "$PAT" ]; then
	echo "Enter Azure Personal Access Token (PAT): "
	read PAT
fi

if [ -z "$POOL_NAME" ]; then
	echo "Enter Pool Name:"
	read POOL_NAME
fi

if [ -z "$AGENT_NAME" ]; then
	echo "Enter Agent Name:"
	read AGENT_NAME
fi

if [ -z "$ORG_URL" ]; then
	echo "Enter Orginization URL:"
	read ORG_URL
fi

if [ $(uname -m) = "aarch64" ]; then
	AGENT_URL=https://vstsagentpackage.azureedge.net/agent/2.172.2/vsts-agent-linux-arm64-2.172.2.tar.gz
elif [ $(uname -m) = "x86_64" ]; then
	AGENT_URL=https://vstsagentpackage.azureedge.net/agent/2.172.2/vsts-agent-linux-x64-2.172.2.tar.gz
else
	echo "Unsupported platform $(uname -m)"
	exit 1
fi

mkdir -p agent
echo "Downloading Azure Linux Agent for ARM64"
wget $AGENT_URL -O vsts-agent.tar.gz -c
echo "Extracting agent"
tar zxvf vsts-agent.tar.gz -C ./agent/
echo "Removing compressed file"

cd agent
./config.sh --unattended --url $ORG_URL --auth pat --token $PAT --pool $POOL_NAME --agent $AGENT_NAME-$RANDOM --acceptTeeEula 
cd ..
ln -s ./agent/run.sh run.sh
ln -s ./agent/svc.sh svc.sh
./run.sh
