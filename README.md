# td-agent-barito-kubernetes

This repository contains the source files needed to make a Docker image
that collects Docker container log files using [td-agent](http://www.fluentd.org/)
and sends them to [Barito] (https://github.com/BaritoLog/).

This image is designed to be used as a [daemonset](http://kubernetes.io/docs/admin/daemons) in a [Kubernetes](https://github.com/kubernetes/kubernetes) cluster.

Please check [Barito Docker Hub] (https://hub.docker.com/r/barito/td-agent-barito-kubernetes/) for ready to use  image.

## Install plugin using kubectl

`kubectl create -f td-agent-daemonset.yaml`

## Install plugin using Helm Chart

### Option 1 
Go to `helm` directory, then execute `helm install .`

### Option 2

- `helm repo add barito https://baritolog.github.io/helm-charts`
- `helm install barito/td-agent-barito --name=my-app-name`

### If using RBAC authorization

Override `rbac.create` when installing, `helm install . --set rbac.create=true`

## Usage

Sign in to BaritoMarket and find your Application. Barito `Application Secret` & `Produce URL` will be displayed on details page.

### Adding Annotations
* Add annotations to your Pod or Deployment in your kubernetes YAML files.
```shell
annotations:
  fluentd.active: "true"
  barito.applicationSecret: "1234567890"
  barito.produceUrl: "http://some-host:some-port/produce"
```
