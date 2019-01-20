# Dex OAuth Token Access on Kubernetes

This example generates a dex deployment in kubernetes using the github
connector for authentication.

It is based on the [dexipd/dex project](https://github.com/dexidp/dex/blob/master/Documentation/kubernetes.md) and reuses code from the example app described there.


## Run it

To run it you need:
- the latest [spiff++](https://github.com/mandelsoft/spiff) version from dev branch
- the upcoming external dns controller manager from the [Gardener Project](https://github.com/gardener).
  Alternativly any other dns controller manager can be used as long as the dnsname 
  for a load balancer service is just requested using an annotation
  (see [config.yaml.example](example/config.yaml.example))
- appropriate _DNSProvider_ resources in your cluster
- docker (if you want to build an own image)

Copy the `example/config.yaml.example`to `deploy/state/config.yaml` and
configure it accordingly.

Now just execute:

```bash
kubectl create namespace <your selected namespace>
deploy/gen.sh
kubectl apply -f deploy/gen/manifest.yaml
```

This is just a first step. The final goal is to extend this example towards a complete kubeconfig generation that can be used to authenticate kubectl against a kubernetes cluster.

## Build it

Just execute

```bash
docker build . -t <your tag>
docker push <your tag>
```

Don't forget to configure your new image in the `config.yaml`

Alternatively use `dep ensure` to update the vendor folder and develop/build
it locally.
