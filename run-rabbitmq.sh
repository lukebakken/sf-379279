#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

_tmp="$(realpath "$(dirname "$BASH_SOURCE")")"
readonly script_dir="$_tmp"
unset _tmp

readonly rmq_version='3.12.13'

if [[ ! -f "rabbitmq-server-generic-unix-$rmq_version.tar.xz" ]]
then
    curl -LO "https://github.com/rabbitmq/rabbitmq-server/releases/download/v$rmq_version/rabbitmq-server-generic-unix-$rmq_version.tar.xz"
fi

if [[ ! -d "rabbitmq_server-$rmq_version" ]]
then
    tar xf "rabbitmq-server-generic-unix-$rmq_version.tar.xz"
fi

export RABBITMQ_ALLOW_INPUT='true'
export RABBITMQ_CONFIG_FILE="$script_dir/rabbitmq.conf"
export LOG='debug'
"$script_dir/rabbitmq_server-$rmq_version/sbin/rabbitmq-server"
