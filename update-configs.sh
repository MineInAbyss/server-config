#!/bin/bash
ansible-pull -U "https://github.com/MineInAbyss/server-config.git" -d "/opt/mineinabyss-configs" --only-if-changed
