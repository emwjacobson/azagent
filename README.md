# DEPRECATED

This has pretty much been obseleted because of Azure's documentation on ["Running a self-hosted agent in Docker"](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker). This has a couple scripts that help with creating a script that auto-downloads the agent and registers it to a pool.


## Azure Agent Quickstart

This is a quick bootstrap program for downloading, extracting, and registering an agent into an Agent pool.

More info about setting up [Agent Pools](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/agents) and using [Linux agents](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/v2-linux).

When setting up the agent you will need
 - A Personal Access Token (PAT)
 - Organization URL
 - Agent Pool name
 - Agent Name

Current host architectures are x86_64(amd64) and ARM64, and the current version is 2.172.2.

## Usage 
Running `setup.sh` will ask for your PAT, Organization URL, Agent Pool name, and Agent name. You can also set these as environmental variables, in which case it won't ask for them during setup.

The agent will be added to the agent pool with a random number added to it. 
Eg if I made the Agent Name "MyAgent", it will appear in the pool as MyAgent-#####.

The default action will run `run.sh`, an 'interactive' agent session. See [here](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/v2-linux?view=azure-devops#run-as-a-systemd-service) about running it as a systemd service.

Running `remove.sh` will again ask for PAT (or not if environmental variable) and uninstall the agent that was previously installed.

Symlinks are made in the current directory to the `run.sh` and `svc.sh` of the agent, to save some steps if you want to stop and start your agent easier.
