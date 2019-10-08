# OPAFugeCodePipeline
Integration of OPA, codepipeline deployment and Fugue baseline/drift detection
 
Example Commands:

terraform apply -auto-approve

terraform destroy -auto-approve

aws cloudformation delete-stack --stack-name testforcarl --profile e3_sandbox

aws cloudformation create-stack --stack-name testforcarl --template-body file://OPACodepipelineFugue.yaml --parameters file://OPACodepipelineFugue-configuration.json

curl -L -o opa https://github.com/open-policy-agent/opa/releases/download/v0.13.3/opa_linux_amd64 && chmod +x opa && mv opa /usr/bin


