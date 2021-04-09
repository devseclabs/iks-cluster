# IKS and NV Deployment

### Usage

1. Clone the project and choose your cloud provider
2. update values in  ```terraform.tfvars.tpl``` inside the folders
3. rename the file to ```terraform.tfvars```
4. log into your IBM cloud provider ```ibmcloud login ```
--- download ks pluging for ibmcloud ---
5. deploy your /infra fisrt:
    - install plugins `terraform init`
    - install infra and helm release `terraform apply` 
5. deploy NV /nv:
    - install plugins `terraform init`
    - install infra and helm release `terraform apply`
6. clean up:
    - finish your lab and destroy resources `terraform destroy`
