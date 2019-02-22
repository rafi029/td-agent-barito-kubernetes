# Changelog

**0.2.8**

- Re-introduce kubernetes filter, we should only remove the annotation match instead of the whole filter in the previous version.

**0.2.7**

- Remove the needs for adding annotation for barito agent to start capturing logs

**0.2.6**

- Parameterize configmap so that multiple td-agent-barito-kubernetes can be installed

**0.2.5**

- Fix typo, supposed to be `fluentd.active = true` annotations

**0.2.4**

- Support both `barito.active = true` and `fluent.active = true` annotations

**0.2.3**

- Automatically roll deployments when configmaps or secrets change using checksum in DaemonSet annotation
