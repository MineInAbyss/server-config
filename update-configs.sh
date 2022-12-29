#!/bin/bash
ansible-pull -U "https://github.com/MineInAbyss/server-config.git" -d "/home/container/downloaded-configs" --checkout ${CONFIG_PULL_BRANCH:=master} -v
