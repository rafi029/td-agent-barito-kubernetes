# td-agent-barito-kubernetes

This repository contains the source files needed to make a Docker image that collects Docker container log files using [td-agent](http://www.fluentd.org/) and sends them to [Barito](https://github.com/BaritoLog/).

This image is designed to be used as a [daemonset](http://kubernetes.io/docs/admin/daemons) in a [Kubernetes](https://github.com/kubernetes/kubernetes) cluster. Every new version will be pushed to [Barito Docker Hub](https://hub.docker.com/r/barito/td-agent-barito-kubernetes/)

Because there are additional configurations that have to be made, this image full functionality can only be realized when you install it using our [helm chart](https://github.com/BaritoLog/helm-charts).

## Usage

Sign in to BaritoMarket and find your Application Group. Barito `Application Group Secret` and `Produce URL` will be displayed, make note of those details.

### Install Helm Chart

Add our helm chart repo

```shell
helm repo add barito https://baritolog.github.io/helm-charts
```

Create a custom yaml containing helm chart values to specify app that you want its logs to be forwarded, example:

```yaml
# myApps.yaml
apps:
  - name: my-app-1
    applicationGroupSecret: abc
    baritoAppName: My App 1
    produceUrl: https://barito-router.my-domain.com/produce_batch
  - name: my-app-2
    applicationGroupSecret: def
    baritoAppName: My App 2
    produceUrl: https://barito-router.my-domain.com/produce_batch
```

Install using helm

```shell
helm install barito/td-agent-barito --name=td-agent-barito --values=myApps.yaml
```

### If using RBAC authorization

Override `rbac.create` when installing, `--set rbac.create=true`

### Add Annotations

* Add annotations to your Pod or Deployment in your kubernetes YAML files to turn logging on or off.

```shell
spec:
  template:
    metadata:
      annotations:
        barito.active: "true"
```

## Notes

If not specified, DaemonSet will have memory limits of `1 Gi` and memory requests `512Mi`. Use `--set resources.limits.memory=XX` or `--set resources.requests.memory=XX` to override.
