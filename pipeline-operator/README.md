# Algo.Run Pipeline Operator

Algo.Run is a data pipeline orchestration system designed for business automation workflows, machine learning model deployments and realtime data stream processing.

Current chart version is `0.1.1`

Source code can be found [here](https://github.com/algohubhq/pipeline-operator)

## TL;DR

```bash
$ helm repo add algohub https://charts.algohub.com
$ kubectl create namespace algorun
$ helm install my-pipeline-operator algohub/pipeline-operator --namespace algorun
```

## Introduction
The pipeline operator facilitates versioned, portable and easily deployable data pipelines on any Kubernetes cluster. Processing nodes (algos) can be created with any containerized data processing tools and languages, which enables easy integration with existing codebase.
A pipeline can be created through a simple yet powerful declarative API implemented as Kubernetes CRDs. 
This chart bootstraps the pipeline operator deployment using the Helm package manager.

Check out the [documentation](https://algohub.com/lc/docs) for more info.

## Features
* **Declarative API** - Create reusable pipelines using purely yaml definitions
* **Processing Nodes** - Use any HTTP, gRPC microservice or even executables as processing algos
* **Data Connectors** - Provision Kafka Connect data connectors
* **Endpoint Management** - Deploys HTTP and gRPC endpoints to push data into the pipeline from external systems
* **Event Hooks** - Subscribe to pipeline events with webhooks to receive output data
* **Security** - Automatic provisioning of TLS for Kafka and Endpoints. mTLS, sasl scram, plain Kafka authentication.
* **Retry Strategies** - Built-in Kafka retry and dead-letter-queue strategies. 

## Requirements

The data plane for algo.run pipelines is based on Kafka and thus a Kafka cluster is required. Currently, in order to automatically provision Kafka Connect data connectors, Kafka Topics, mTLS and encryption, the [Strimzi Kafka Operator](https://strimzi.io/) must be installed and configured in the Kubernetes cluster. 
To install the strimzi kafka operator:
- [New Kafka cluster](https://strimzi.io/docs/quickstart/latest/#proc-install-product-str)

For a development Kafka cluster ready for algo.run:
```bash
$ helm repo add strimzi http://strimzi.io/charts/
$ kubectl create namespace kafka
$ helm install kafka-operator strimzi/strimzi-kafka-operator --set watchNamespaces="{algorun}" --namespace kafka
```

The pipeline operator also utilizes [Ambassador](https://www.getambassador.io/) to create dynamic ingress mappings into pipeline deployment endpoints.

For a development Ambassador deployment ready for algo.run:
```bash
$ helm repo add datawire https://getambassador.io
$ kubectl create namespace ambassador
$ helm install ambassador datawire/ambassador --set enableAES="false" --namespace ambassador
```

Storing data in S3 compatible storage is also supported (not required), if embedding the output data in the kafka stream is not desired.
We recommend [Minio](https://min.io/) for storage within the kubernetes cluster, otherwise any external S3 bucket can be used.

## Installation

#### Install helm
https://github.com/helm/helm#install

#### Add the algohub helm chart repo
```bash
$ helm repo add algohub https://charts.algohub.com
```

#### Creating a separate namespace for algo.run resources is recommended
```bash
$ kubectl create namespace algorun
```

#### Install the pipeline operator into the namespace
```bash
$ helm install algorun-pipeline-operator algohub/pipeline-operator --namespace algorun
```

This deploys the Algo.Run Pipeline Operator on the Kubernetes cluster with the default configuration.
The [Chart Values](#Chart Values) section below lists the parameters that can be configured during installation.



## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Set the affinity. ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/ |
| algoRunnerImage.pullPolicy | string | `"IfNotPresent"` | The algo-runner image pull policy |
| algoRunnerImage.repository | string | `"algohub/algo-runner"` | Set the default image and tag that will be used for the algo-runner sidecar. The algoRunnerImage may be overridden by a pipeline deployment |
| algoRunnerImage.tag | string | `"240153868a5b21207b61270762bffc978615964a"` | The algo-runner image tag |
| autoscaling.enabled | bool | `false` | Enable autoscaling using a HorizontalPodAutoscaler |
| autoscaling.maxReplicas | int | `100` | Maximum replicas created by the HorizontalPodAutoscaler |
| autoscaling.metrics | string | `nil` | Metrics for the HorizontalPodAutoscaler ref: https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/#autoscaling-on-multiple-metrics-and-custom-metrics |
| autoscaling.minReplicas | int | `1` | Minimum replicas created by the HorizontalPodAutoscaler |
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
| kafka.auth.authCertSecretKey | string | `"user.crt"` | The key (file name) for the cert within the secret |
| kafka.auth.authKeySecretKey | string | `"user.key"` | The key (file name) for the private key within the secret |
| kafka.auth.authSecretName | string | `"{kafkaClusterName}-{deploymentowner}-{deploymentname}"` | If auth type "tls" then the name of the secret that contains the client X509 cert The name can use a template as certs can be generated dynamically by the kafka operator If auth type "scram-sha-512" or "plain" then the name of the secret that contains the password |
| kafka.auth.passwordSecretKey | string | `nil` | The key (file name) for the password within the secret |
| kafka.auth.type | string | `""` | Enable communication over TLS to the kafka brokers  |
| kafka.clusterName | string | `"kafka"` | The name of the kafka cluster (as defined for the kafka operator) |
| kafka.namespace | string | `"kafka"` | The namespace the kafka operator is installed on |
| kafka.operatorType | string | `"strimzi"` | Currently only the strimzi kafka operator is supported |
| kafka.tls.caCertSecretKey | string | `"ca.crt"` | The key (file name) within the secret |
| kafka.tls.caSecretName | string | `"kafka-cluster-ca-cert"` | Name of the secret that contains the certificate authority X509 cert |
| kafka.tls.enabled | bool | `true` | Enable communication over TLS to the kafka brokers  |
| metrics.algoServiceMonitor.additionalLabels | object | `{}` | Used to pass Labels that are used by the Prometheus installed in your cluster to select Service Monitors to work with ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#prometheusspec |
| metrics.algoServiceMonitor.enabled | bool | `true` | If the prometheus operator is installed in your cluster, set to true to create a Service Monitor Entry |
| metrics.algoServiceMonitor.honorLabels | bool | `false` | Specify honorLabels parameter to add the scrape endpoint |
| metrics.algoServiceMonitor.interval | string | `"30s"` | The interval at which metrics should be scraped |
| metrics.algoServiceMonitor.namespace | string | `nil` | Specify the namespace in which the serviceMonitor resource will be created |
| metrics.algoServiceMonitor.relabellings | string | `nil` | Specify Metric Relabellings to add to the scrape endpoint |
| metrics.algoServiceMonitor.release | string | `nil` | Specify the release for ServiceMonitor. Sometimes it should be custom for prometheus operator to work |
| metrics.algoServiceMonitor.scrapeTimeout | string | `"30s"` | Specify the timeout after which the scrape is ended |
| metrics.createDashboards | bool | `true` | Install grafana dashboards and data sources. The prometheus operator must be install with the grafana sidecar enabled. |
| metrics.dataConnectorServiceMonitor.additionalLabels | object | `{}` | Used to pass Labels that are used by the Prometheus installed in your cluster to select Service Monitors to work with ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#prometheusspec |
| metrics.dataConnectorServiceMonitor.enabled | bool | `true` | If the prometheus operator is installed in your cluster, set to true to create a Service Monitor Entry |
| metrics.dataConnectorServiceMonitor.honorLabels | bool | `false` | Specify honorLabels parameter to add the scrape endpoint |
| metrics.dataConnectorServiceMonitor.interval | string | `"30s"` | The interval at which metrics should be scraped |
| metrics.dataConnectorServiceMonitor.namespace | string | `nil` | Specify the namespace in which the serviceMonitor resource will be created |
| metrics.dataConnectorServiceMonitor.relabellings | string | `nil` | Specify Metric Relabellings to add to the scrape endpoint |
| metrics.dataConnectorServiceMonitor.release | string | `nil` | Specify the release for ServiceMonitor. Sometimes it should be custom for prometheus operator to work |
| metrics.dataConnectorServiceMonitor.scrapeTimeout | string | `"30s"` | Specify the timeout after which the scrape is ended |
| metrics.enabled | bool | `true` | Enable metrics collection with the prometheus operator |
| metrics.endpointServiceMonitor.additionalLabels | object | `{}` | Used to pass Labels that are used by the Prometheus installed in your cluster to select Service Monitors to work with ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#prometheusspec |
| metrics.endpointServiceMonitor.enabled | bool | `true` | If the prometheus operator is installed in your cluster, set to true to create a Service Monitor Entry |
| metrics.endpointServiceMonitor.honorLabels | bool | `false` | Specify honorLabels parameter to add the scrape endpoint |
| metrics.endpointServiceMonitor.interval | string | `"30s"` | The interval at which metrics should be scraped |
| metrics.endpointServiceMonitor.namespace | string | `nil` | Specify the namespace in which the serviceMonitor resource will be created |
| metrics.endpointServiceMonitor.relabellings | string | `nil` | Specify Metric Relabellings to add to the scrape endpoint |
| metrics.endpointServiceMonitor.release | string | `nil` | Specify the release for ServiceMonitor. Sometimes it should be custom for prometheus operator to work |
| metrics.endpointServiceMonitor.scrapeTimeout | string | `"30s"` | Specify the timeout after which the scrape is ended |
| metrics.pipelineOperatorServiceMonitor.additionalLabels | object | `{}` | Used to pass Labels that are used by the Prometheus installed in your cluster to select Service Monitors to work with ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#prometheusspec |
| metrics.pipelineOperatorServiceMonitor.enabled | bool | `true` | If the prometheus operator is installed in your cluster, set to true to create a Service Monitor Entry |
| metrics.pipelineOperatorServiceMonitor.honorLabels | bool | `false` | Specify honorLabels parameter to add the scrape endpoint |
| metrics.pipelineOperatorServiceMonitor.interval | string | `"30s"` | The interval at which metrics should be scraped |
| metrics.pipelineOperatorServiceMonitor.namespace | string | `nil` | Specify the namespace in which the serviceMonitor resource will be created |
| metrics.pipelineOperatorServiceMonitor.relabellings | string | `nil` | Specify Metric Relabellings to add to the scrape endpoint |
| metrics.pipelineOperatorServiceMonitor.release | string | `nil` | Specify the release for ServiceMonitor. Sometimes it should be custom for prometheus operator to work |
| metrics.pipelineOperatorServiceMonitor.scrapeTimeout | string | `"30s"` | Specify the timeout after which the scrape is ended |
| metrics.prometheusOperatorNamespace | string | `"prometheus-operator"` | Prometheus operator namespace to create grafana dashboard and data source resources in |
| metrics.serviceMonitorNamespace | string | `nil` | The serviceMonitorNamespace sets the namespace the servicemonitor will be created in. By default, it is created in the release namespace. If necessary, set the namespace the prometheus operator is watching for service monitors. |
| nameOverride | string | `""` | Manually set metadata for the Release. Defaults to .Chart.Name |
| nodeSelector | object | `{}` | Set the node selector.  ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/ |
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
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | Set the tolerations.  ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |