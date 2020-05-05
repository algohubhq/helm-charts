algorun-pipeline-operator
=========================
The algo.run pipeline operator orchestrates data processing, machine learning deployment and business automation pipelines.

Current chart version is `0.1.1`

Source code can be found [here](https://github.com/algohubhq/pipeline-operator)

## Additional Information
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore
et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.



## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| algoRunnerImage.pullPolicy | string | `"IfNotPresent"` |  |
| algoRunnerImage.repository | string | `"nginx"` |  |
| algoRunnerImage.tag | string | `""` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| endpointImage.pullPolicy | string | `"IfNotPresent"` |  |
| endpointImage.repository | string | `"nginx"` |  |
| endpointImage.tag | string | `""` |  |
| env | object | `{}` |  |
| eventHookImage.pullPolicy | string | `"IfNotPresent"` |  |
| eventHookImage.repository | string | `"nginx"` |  |
| eventHookImage.tag | string | `""` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"nginx"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| kafka.auth.authCertSecretKey | string | `"user.crt"` |  |
| kafka.auth.authKeySecretKey | string | `"user.key"` |  |
| kafka.auth.authSecretName | string | `"{kafkaClusterName}-{deploymentowner}-{deploymentname}"` |  |
| kafka.auth.type | string | `"tls"` |  |
| kafka.clusterName | string | `"kafka"` |  |
| kafka.namespace | string | `"kafka"` |  |
| kafka.operatorType | string | `"strimzi"` |  |
| kafka.tls.caCertSecretKey | string | `"ca.crt"` |  |
| kafka.tls.caSecretName | string | `"kafka-cluster-ca-cert"` |  |
| kafka.tls.enabled | bool | `true` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| notifications.enabled | bool | `false` |  |
| notifications.url | string | `nil` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| rbac.create | bool | `true` |  |
| rbac.nameOverride | string | `nil` |  |
| rbac.podSecurityPolicies | list | `[]` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| scope.singleNamespace | bool | `false` |  |
| scope.watchNamespaces | string | `""` |  |
| securityContext | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |