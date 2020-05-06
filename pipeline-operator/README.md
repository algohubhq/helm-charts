algorun-pipeline-operator
=========================
The algo.run pipeline operator orchestrates data processing, machine learning deployment and business automation pipelines.

Current chart version is `0.1.1`

Source code can be found [here](https://github.com/algohubhq/pipeline-operator)

## TL;DR

```bash
$ helm repo add algohub https://charts.algohub.com
$ helm install my-pipeline-operator algohub/pipeline-operator
```

## Introduction
The algo.run pipeline operator is designed to orchestrate the deployment of any Kafka based data pipeline into any kubernetes cluster. 
A pipeline can be created through a simple yet powerful declarative API implemented as Kubernetes CRDs. 
This chart bootstraps the pipleine operator deployment using the Helm package manager.

## Requirements

## Installation

#### Install helm
https://github.com/helm/helm#install

#### Add the algohub helm chart repo
```bash
$ helm repo add algohub https://charts.algohub.com
```



## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Set the affinity. See https://kubernetes.io/docs/concepts/configuration/assign-pod-node/ |
| algoRunnerImage.pullPolicy | string | `"IfNotPresent"` | The algo-runner image pull policy |
| algoRunnerImage.repository | string | `"algohub/algo-runner"` | Set the default image and tag that will be used for the algo-runner sidecar. The algoRunnerImage may be overridden by a pipeline deployment |
| algoRunnerImage.tag | string | `"240153868a5b21207b61270762bffc978615964a"` | The algo-runner image tag |
| autoscaling.enabled | bool | `false` | Enable autoscaling using a HorizontalPodAutoscaler |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.metrics[0].resource.name | string | `"cpu"` |  |
| autoscaling.metrics[0].resource.targetAverageUtilization | int | `80` |  |
| autoscaling.metrics[0].type | string | `"Resource"` |  |
| autoscaling.metrics[1].resource.name | string | `"memory"` |  |
| autoscaling.metrics[1].resource.targetAverageUtilization | int | `80` |  |
| autoscaling.metrics[1].type | string | `"Resource"` |  |
| autoscaling.minReplicas | int | `1` |  |
| endpointImage.pullPolicy | string | `"IfNotPresent"` | The pipeline endpoint image pull policy |
| endpointImage.repository | string | `"algohub/deployment-endpoint"` | Set the default image and tag that will be used for the pipeline endpoint gateway. The endpointImage may be overridden by a pipeline deployment |
| endpointImage.tag | string | `"7f2acda823d48893838d03f2b706684cf84b7d7a"` | The pipeline endpoint image tag |
| env | object | `{}` | Additional container environment variables |
| eventHookImage.pullPolicy | string | `"IfNotPresent"` | The event hook runner image pull policy |
| eventHookImage.repository | string | `"algohub/event-hook-runner"` | Set the default image and tag that will be used for the pipeline hook runner. The eventHookImage may be overridden by a pipeline deployment |
| eventHookImage.tag | string | `"5ae767f855bf45a102a5327f7685cc89d4a45d8d"` | The event hook runner image tag |
| fullnameOverride | string | `""` | Defaults to .Release.Name-.Chart.Name unless .Release.Name contains "algorun-pipeline-operator" |
| image | object | `{"pullPolicy":"IfNotPresent","repository":"algohub/pipeline-operator","tag":"eb2896135958feb9c2f7b45efd79ad76ea8ccfef"}` | Set the image and tag for the pipeline operator |
| imagePullSecrets | list | `[]` | Image pull secrets if private images are used |
| kafka.auth.authCertSecretKey | string | `"user.crt"` |  |
| kafka.auth.authKeySecretKey | string | `"user.key"` |  |
| kafka.auth.authSecretName | string | `""` |  |
| kafka.auth.passwordSecretKey | string | `""` |  |
| kafka.auth.type | string | `""` | Enable communication over TLS to the kafka brokers  |
| kafka.clusterName | string | `"kafka"` | The name of the kafka cluster (as defined for the kafka operator) |
| kafka.namespace | string | `"kafka"` | The namespace the kafka operator is installed on |
| kafka.operatorType | string | `"strimzi"` | Currently only the strimzi kafka operator is supported |
| kafka.tls.caCertSecretKey | string | `"ca.crt"` | The key (file name) within the secret |
| kafka.tls.caSecretName | string | `"kafka-cluster-ca-cert"` | Name of the secret that contains the certificate authority X509 cert |
| kafka.tls.enabled | bool | `true` | Enable communication over TLS to the kafka brokers  |
| metrics.algoServiceMonitor.additionalLabels | object | `{}` |  |
| metrics.algoServiceMonitor.enabled | bool | `true` |  |
| metrics.algoServiceMonitor.honorLabels | bool | `false` |  |
| metrics.algoServiceMonitor.interval | string | `"30s"` |  |
| metrics.dataConnectorServiceMonitor.additionalLabels | object | `{}` |  |
| metrics.dataConnectorServiceMonitor.enabled | bool | `true` |  |
| metrics.dataConnectorServiceMonitor.honorLabels | bool | `false` |  |
| metrics.dataConnectorServiceMonitor.interval | string | `"30s"` |  |
| metrics.enabled | bool | `true` |  |
| metrics.endpointServiceMonitor.additionalLabels | object | `{}` |  |
| metrics.endpointServiceMonitor.enabled | bool | `true` |  |
| metrics.endpointServiceMonitor.honorLabels | bool | `false` |  |
| metrics.endpointServiceMonitor.interval | string | `"30s"` |  |
| metrics.pipelineOperatorServiceMonitor.additionalLabels | object | `{}` |  |
| metrics.pipelineOperatorServiceMonitor.enabled | bool | `true` |  |
| metrics.pipelineOperatorServiceMonitor.honorLabels | bool | `false` |  |
| metrics.pipelineOperatorServiceMonitor.interval | string | `"30s"` |  |
| metrics.prometheusOperatorNamespace | string | `"prometheus-operator"` |  |
| nameOverride | string | `""` | Manually set metadata for the Release. Defaults to .Chart.Name |
| nodeSelector | object | `{}` | Set the node selector. See https://kubernetes.io/docs/concepts/configuration/assign-pod-node/ |
| notifications.enabled | bool | `false` | Enable webhook notifications to be sent for pipeline status changes |
| notifications.url | string | `nil` | Url to send status event notifications to |
| podAnnotations | object | `{}` | Additional annotations to add to the pod |
| podSecurityContext | object | `{}` | Set security context for the pod |
| rbac.create | bool | `true` | Specifies whether RBAC resources should be created |
| rbac.nameOverride | string | `nil` | Name of the RBAC resources defaults to the name of the release. Set nameOverride when installing pipeline operator with cluster-wide scope in different namespaces with the same release name to avoid conflicts. |
| rbac.podSecurityPolicies | list | `[]` | podSecurityPolicies to be added |
| replicaCount | int | `1` | (int) Number of pipeline-operator pods to load balance between |
| resources | object | `{}` | Set the resource requests and limits |
| scope.type | string | `"cluster"` | If set to "cluster", the pipeline operator will manage kafka and ambassador resources in any namespace and create Cluster RBAC if rbac.enabled: true  If set to "namespace" (Not recommended) the ambassador, kafka operator and pipeline operator must be installed in the same namespace. |
| scope.watchNamespace | string | `""` | The namespace to watch for new pipeline deployments. Default "" watches all namespaces. |
| securityContext | object | `{}` | Set security context for the deployment |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` | Set the tolerations. See https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |