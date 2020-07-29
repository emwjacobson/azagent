#!/bin/bash

if [ -z "$PAT" ]; then
	echo "Enter Azure Personal Access Token (PAT): "
	read PAT
fi

cd agent
./config.sh remove --unattended --url https://dev.azure.com/emwjacobson --auth pat --token $PAT --pool Jetson
cd ..
rm -rf agent
rm run.sh
rm svc.sh
