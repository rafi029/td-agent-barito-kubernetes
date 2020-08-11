#!/bin/bash -ex

apt-get update
apt-get install -y -q --no-install-recommends \
  curl ca-certificates make g++ sudo bash

/usr/bin/curl -sSL https://toolbelt.treasuredata.com/sh/install-ubuntu-xenial-td-agent3.sh | sh

sed -i -e "s/USER=td-agent/USER=root/" -e "s/GROUP=td-agent/GROUP=root/" /etc/init.d/td-agent

td-agent-gem install --no-document fluent-plugin-kubernetes_metadata_filter
td-agent-gem install --no-document fluent-plugin-prometheus
td-agent-gem install --no-document fluent-plugin-barito

# Remove docs and postgres references
rm -rf /opt/td-agent/embedded/share/doc \
  /opt/td-agent/embedded/share/gtk-doc \
  /opt/td-agent/embedded/lib/postgresql \
  /opt/td-agent/embedded/bin/postgres \
  /opt/td-agent/embedded/share/postgresql

curl -Lo /tmp/tini.deb https://github.com/krallin/tini/releases/download/v0.19.0/tini_0.19.0-amd64.deb
curl -Lo /tmp/watchexec.deb https://github.com/watchexec/watchexec/releases/download/1.14.0/watchexec-1.14.0-x86_64-unknown-linux-gnu.deb
apt-get install -y -q --no-install-recommends \
  /tmp/tini.deb \
  /tmp/watchexec.deb

apt-get remove -y make g++
apt-get autoremove -y
apt-get clean -y

rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
