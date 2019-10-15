# Automated Infrastructure Compliance Framework 
For help, email support@nltgis.com

### What is AICF?
The Automated Infrastructure Compliance Framework is an open-source integrated pipeline for deploying and monitoring infrastructure.  Specific features include:
* Pre-deployment policy checking using Open Policy Agent
* Post-deployment AWS/Azure drift detection using Fugue.co
* Terraform for Infrastructure-as-Code deployments

### Technical Summary
AICF is built on AWS Codepipeline and AWS Codebuild and integrates Open Policy Agent, Terraform, and Fugue.

###Deployment/installation overview
**https://aicf.nltmso.com
**Console
**CLI
*How to run AICF












# OPAFugeCodePipeline
Integration of OPA, codepipeline deployment and Fugue baseline/drift detection
 
**Some Example Commands:**

_Apply_
terraform apply -auto-approve

_Destroy_
terraform destroy -auto-approve

_Delete Stack_
aws cloudformation delete-stack --stack-name testforcarl --profile e3_sandbox

_Create Stack_
aws cloudformation create-stack --stack-name testforcarl --template-body file://OPACodepipelineFugue.yaml --parameters file://OPACodepipelineFugue-configuration.json

curl -L -o opa https://github.com/open-policy-agent/opa/releases/download/v0.13.3/opa_linux_amd64 && chmod +x opa && mv opa /usr/bin


