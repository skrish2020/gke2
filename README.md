# gke2
1. Created the github repository
2. Created the terraform modules for provider GCP to create VPC, SUB NET, NAT Gateway, GKE Clusters in US-CENTRAL1
3. Used terraform init, plan, apply to create the cluster
4. Added terraform module to create a GCE in US Central 1a zone. 
4a. Moved the terraform state file to GCP Bucket
5. Created and deployed an ATLANTIS SERVER on port 4141. Provided access to the same TFState file in the GCP bucket.
6. Create webhook in github repository
7. Successfully test Pull / merge with Atlantis apply (see screenshot Fig 1)
8. Used kubectl to install argocd in GKE nodes
9. Configured github and argocd. 
10. Successfully tested a change to deployment by pushing to github. ArgoCD was able to deploy successfully the updated yaml from github (see screenshot Fig 2)
