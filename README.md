### Debug terraform

```shell
cd ./debug
terraform init
# 进入控制台查看变量，控制台 exit 退出
terraform console -var-file teams-config.tfvars
terraform console
```

### 查看执行日志
```shell
export TF_LOG=1
```