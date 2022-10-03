# terraform for sandbox

- Variables go in a file `terraform.tfvars` (see `terraform.tfvars.example`)
- Secrets go in `secret.auto.tfvars`, you probably don't need this unless you are using Azure.

## Using

```bash
# Login to GCP
gcloud auth application-default login

# init
terraform init -upgrade

# plan
terraform plan

# apply
terraform apply
```


## Developing

```bash
# build images
docker compose build
docker compose pull
# see available targets
docker compose run --rm devtools help
# ...
docker compose run --rm devtools terraform-reinit
# validate
docker compose run --rm devtools validate
# fix validation errors
docker compose run --rm devtools validate-fix
# ...
docker compose run --rm devtools terraform apply # -auto-approve
```

```
gcloud projects list
docker compose run --rm devtools terraform destroy -target=module.try_bucket_safe
docker compose run --rm devtools terraform destroy -target=module.try_bucket_defaults


```
