# Mine In Abyss Server Config

We use this repo to keep track of our servers' configuration files.

We use ansible to set up a cron job that runs `ansible-pull` daily, which will run the `local.yml` playbook as it is on GitHub. 

The playbook will:
- Copy files appropriate to each server as defined in `host_vars`
- (in the future) merge yaml files and replace secrets using jinja2 templates
- Restart the servers

Ansible-pull also has an option to only run when changes are present in git, which we use.

## Setup

- Set the server hostname to something identifiable
- Configure what servers run on that server under `host_vars/<hostname>.yml`
- Install Ansible on your server
- Run the command inside `update-configs.sh` on the appropriate server. The rest is done automatically.

## License

The (Ansible) automation part of this project is under the MIT license in the `LICENSE` file. The server configs themselves (under `servers/`) remain unlicensed.
