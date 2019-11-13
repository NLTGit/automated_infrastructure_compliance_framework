# Automated Infrastructure Compliance Framework 
For help, email support@nltgis.com

## What is AICF?
The Automated Infrastructure Compliance Framework is an open-source integrated pipeline for deploying and monitoring infrastructure.  Specific features include:
* Pre-deployment policy checking using Open Policy Agent
* Post-deployment AWS/Azure drift detection using Fugue.co
* Terraform for Infrastructure-as-Code deployments

## Technical Summary
AICF is currently built on AWS Codepipeline and AWS Codebuild and integrates Open Policy Agent, Terraform, and Fugue.

## Deployment/installation overview
Before deploying by any of the following methods, the values for the following configuration parameters must be gathered:
  
"ApplicationName" - Any name of your choosing for the AWS codepiplne reference name  
"ArtifactS3Bucket" - Name of existing AWS S3 bucket for the AWS codepiplne artifact store  
"GitHubOAuthToken" - programmatic auth token for github user  
"GitHubUser" - Github user name  
"GitHubRepository" - Github repository where terraform '.tf' files are   
"GitHubBranch" - Specific Github repository branch to be used for the above terraform files  
"TerraformSha256" - Sha256 hash of terraform binary  
"TerraformVersion" - Version of of terraform to use during initiation of terraform environment  
"TerraformCloudToken" - programmatic auth token for terraform enterprise environment  
"Intervalinseconds" - Interval, in seconds, that Fugue will scan AWS evironment  
"Fugueenvironmentid" - Id of Fugue environment  
"FugueCLIENTID" - Client Id of Fugue username  
"FugueCLIENTSECRET" - Secret of the Fugue client Id  
  
**CLI method**  
In order to deployment AICF via bash CLI environment, one must first have the aws cli binary installed and have properfly configured the ~/.aws/config and ~/.aws/credentials files

1) Create of json formatted configuration file with the parameters descriped in the Deployment/installation overview  

2) Run the command below, subsituting the name "testStack" with one of your choosing.

```sh
$ aws cloudformation create-stack --stack-name testStack --template-body file://aicf.yaml --parameters file://aicf-configuration.json --capabilities CAPABILITY_NAMED_IAM
```  

**Accelerated CloudFormation method**  
1) Login to the AWS account you wish to deploy the AICF 

2) Click [here to deploy the AICF Cloudformation stack to your account.](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?AICFCodepipelineStack&templateURL=https://s3.amazonaws.com/automated-infrastructure-compliance-framework/aicf.yaml)  

3) Click "Next", give your new stack a name and then fill in the variable parameters that are required to deploy the pipeline.

4) Complete Steps 6 & 7 in the **Console section described below
  
**Manual Method Using the AWS Console**  
1) Log onto the your AWS web console
  
2) Navigate to the AWS cloudformation service page:
<img src="images/Screen Shot 2019-10-15 at 8.40.54 AM.png">
  
3) Click on "Create Stack"
<img src="images/Screen Shot 2019-10-15 at 8.43.36 AM.png">
  
4) Ensure "Template is Ready" and "Upload a template file" are chosen. Choose the cloudformation template file (OPAFugueCodepipeline.yaml) in this repository
<img src="images/Screen Shot 2019-10-15 at 8.44.58 AM.png">
  
5) Fill in the parameters with the information gathered in Deployment/installation overview and click next

6) Click next again

7) Ensure the following checkbox is clicked and select "Create Stack"
<img src="images/Screen Shot 2019-10-15 at 8.49.26 AM.png">


## How to run AICF
Once you deplopy the AICF, it is ready to be usedThe first run will initiate itself once the AWS cloudformation stack is created. By default, the AWS pipeline is configured to run manually. In order to run, execute the following steps:

<img src="images/Screen Shot 2019-10-15 at 8.31.10 AM.png">

1) In AWS console, nagivate to the codepipeline service. Click on the reference name, "ApplicationName", you chose above. 

<img src="images/Screen Shot 2019-10-15 at 8.31.27 AM.png">

2) Then, click on "Release Change"

<img alt="Terraform" src="images/Screen Shot 2019-10-15 at 8.31.47 AM.png">

3) Confirm start of pipeline by clicking on "Release"

<img src="images/Screen Shot 2019-10-15 at 8.31.55 AM.png">
 
## **Some Example CLI Commands:**

_Apply_
```sh
$ terraform apply -auto-approve
```  

_Destroy_
```sh
$ terraform destroy -auto-approve
```  

_Delete Stack_
```sh
$ aws cloudformation delete-stack --stack-name testStack --profile e3_sandbox
```  
_Install OPA binary locally_
```sh
curl -L -o opa https://github.com/open-policy-agent/opa/releases/download/v0.13.3/opa_linux_amd64 && chmod +x opa && mv opa /usr/bin
```  

## Contributing
1) Clone repo  
2) Create new branch, make changes and commit and push to remote i.e. `git push --set-upstream origin new-branch`  
3) Log into github and create pull request  

## Contact  
New Light Technologies, Inc.   
Dave Williams - dave.williams.nltgis.com  
Carl Alleyne - carl.alleyne@nltgis.com  
