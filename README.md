<div align="center">

# Mine In Abyss Server Config
[![Discord](https://badgen.net/discord/members/QXPCk2y)](https://discord.gg/QXPCk2y)
![Size](https://img.shields.io/github/repo-size/MineInAbyss/server-config)
[![Contribute](https://shields.io/badge/Contribute-e57be5?logo=github%20sponsors&style=flat&logoColor=white)](https://mineinabyss.com/config)
</div>

We use this repo to keep track of our servers' configuration files. Anyone can request to make changes by following the guide in the `Contribute` badge above!

We use ansible to download and update config files on server startup, running `local.yml` from GitHub using ansible-pull.

## Usage

### Folder structure

`/servers` contains subfolders defining configs for different servers, in it, `servers.yml` defines which configs to copy based on the `SERVER_NAME` env variable.

`plugin-versions.conf` stores plugin versions which don't get installed by this playbook, but using Keepup.

### Per-server config

Each server subfolder contains subfolders that get treated differently.

#### `sync`

Uses rsync to simply copy files over to dest as quickly as possible.

#### `templates`

Copies files and templates them using [Jinja2](https://jinja.palletsprojects.com/en/3.0.x/templates/) with Ansible. Add `.j2` to the file extension to indicate that it's a Jinja2 template.

You can often look up how to do templating for Ansible specifically (ex. "read environment variable ansible") to get an idea for these configs, since it templates them in the same way.

##### Examples

Reading a secret via env variable:
```yaml
secret_api_key: "{{ lookup('ansible.builtin.env', 'MY_SECRET_KEY') }}"
``` 

### Setup
- Install Ansible on your server
- Set the server name as an env variable called `SERVER_NAME` (set `BUNGEE_SERVER` to true/false to decide whether to ignore the `server/minecraft` directory.)
- Configure what servers run on that server under `host_vars/<hostname>.yml
- Run the command inside `update-configs.sh` on the appropriate server. The rest is done automatically.

## License

The (Ansible) automation part of this project is under the MIT license in the `LICENSE` file. The server configs themselves (under `servers/`) remain unlicensed.
