<div align="center">

# Mine In Abyss Server Config
[![Discord](https://badgen.net/discord/members/QXPCk2y)](https://discord.gg/QXPCk2y)
![Size](https://img.shields.io/github/repo-size/MineInAbyss/server-config)
[![Contribute](https://shields.io/badge/Contribute-e57be5?logo=github%20sponsors&style=flat&logoColor=white)](https://mineinabyss.com/config)
</div>

We use this repo to keep track of our servers' configuration files. Anyone can request to make changes by following the guide in the `Contribute` badge above!

We use ansible to download and upate config files on server startup, running the `local.yml` playbook as it is on GitHub. 

The playbook will:
- Copy files appropriate to each server as defined in `host_vars`
- (in the future) merge yaml files and replace secrets using jinja2 templates

Ansible-pull also has an option to only run when changes are present in git, which we use.

## Setup
- Install Ansible on your server
- Set the server name as an env variable called `SERVER_NAME` (set `BUNGEE_SERVER` to true/false to decide whether to ignore the `server/minecraft` directory.)
- Configure what servers run on that server under `host_vars/<hostname>.yml
- Run the command inside `update-configs.sh` on the appropriate server. The rest is done automatically.

## License

The (Ansible) automation part of this project is under the MIT license in the `LICENSE` file. The server configs themselves (under `servers/`) remain unlicensed.
