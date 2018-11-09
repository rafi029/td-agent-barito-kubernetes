# td-agent-barito-kubernetes

This repository contains the source files needed to make a Docker image
that collects Docker container log files using [td-agent](http://www.fluentd.org/)
and sends them to [Barito] (https://github.com/BaritoLog/).

This image is designed to be used as a [daemonset](http://kubernetes.io/docs/admin/daemons) in a [Kubernetes](https://github.com/kubernetes/kubernetes) cluster.

Please check [Barito Docker Hub] (https://hub.docker.com/r/barito/td-agent-barito-kubernetes/) for ready to use  image.

## Add ConfigMap

1. Rename `tdagentconfig.yaml.sample` file to `tdagentconfig.yaml`
2. Add these lines of code right after the `</source>` tag:

```
<match kubernetes.**APP_NAME**>
  @type file
  path /var/log/baritolog
</match>
```

> Notes:
Match events tagged with `kubernetes.**APP_NAME**` and store them to `/var/log/baritolog` directory. @type: your output plugin type. path: your output path

3. Execute
`kubectl apply -f tdagentconfig.yaml` 

## Install plugin using kubectl

`kubectl create -f td-agent-daemonset.yaml`

## Install plugin using Helm Chart

### Option 1 
Go to `helm` directory, then execute `helm install .`

### Option 2

- `helm repo add barito https://baritolog.github.io/helm-charts`
- `helm install barito/td-agent-barito --name=td-agent-barito`

### If using RBAC authorization

Override `rbac.create` when installing, `--set rbac.create=true`

## Usage

Sign in to BaritoMarket and find your Application. Barito `Application Secret` & `Produce URL` will be displayed on details page.

### Add Annotations
* Add annotations to your Pod or Deployment in your kubernetes YAML files.
```shell
spec:
  template:
    metadata:
      annotations:
        fluentd.active: "true"
        barito.applicationSecret: "1234567890"
        barito.produceUrl: "http://some-host:some-port/produce"
```

## Notes

If not specified, DaemonSet will have memory limits `1 Gi` and memory requests `512Mi`, use `--set resources.limits.memory=XX` or `--set resources.requests.memory=XX` to override.