Title: Automated Infrastructure Compliance Framework 
Link to automated deployment of the stack: https://aicf.nltmso.com
Summary: Write a summary here
Contacts:

##Menu-
*What is AICF?
*How can it help?
*Technical design/specs
*How to deploy AICF
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


