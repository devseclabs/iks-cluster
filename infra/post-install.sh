#!/bin/bash
#log in ibm cloud
ibmcloud login -a cloud.ibm.com -r us-south -g Default

#get your cluster info
ibmcloud ks cluster ls

#copy your cluster ID
ibmcloud ks cluster config --cluster [INSERT-YOUR-CLUSTER-ID]

#configure your context
kubectl config current-context

#copy infra output path and update the nv/provider.tf file

#now install neuvector with terraform /nv
cd ../nv
terraform init
terraform plan

#check nodeport nv installation
# kubectl port-forward neuvector-manager-pod 8443:8443
# https://localhost:8443

#optional
# create your Access key in IBM Cloud and pass as env var
# export IC_API_KEY="your-key"