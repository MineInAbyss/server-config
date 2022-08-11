#!/bin/bash
definedBranch=$(cat pull-branch 2>/dev/null)
ansible-pull -U "https://github.com/MineInAbyss/server-config.git" -d "/opt/mineinabyss-configs" --checkout ${definedBranch:=master}
