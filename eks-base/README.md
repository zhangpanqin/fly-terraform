### 设置变量

```terraform
variable "cluster_name" {
    default = "my-eks"
}
```

```shell
# var.cluster_name 输出值
terraform console
```

### cert-manage

已经创建了,cert-manager,cluster-issuer,Certificate
创建 nginx 作为后端服务

```shell

kubectl create deployment nginx --image=nginx:1.12.0
# deployment.apps/nginx created

kubectl expose deployment nginx --type LoadBalancer --port 80
# service/nginx exposed
```

```yaml
apiVersion: extensions/v1
kind: Ingress
metadata:
    name: test-ingress-deploy-k8s-route53-dns
    namespace: default
    annotations:
        kubernetes.io/ingress.class: voyager
        certmanager.k8s.io/issuer: "letsencrypt-staging-dns"
        certmanager.k8s.io/acme-challenge-type: dns01
spec:
    tls:
        -   hosts:
                - kiteci-route53-dns.appscode.me
            secretName: certificate-secret
    rules:
        -   host: kiteci-route53-dns.appscode.me
            http:
                paths:
                    -   backend:
                            serviceName: nginx
                            servicePort: 80
                        path: /
```