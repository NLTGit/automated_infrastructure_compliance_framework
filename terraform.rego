package terraform.analysis

import input as tfplan

########################
# Parameters for Policy
########################
########################
# 1) No ingress port other than 443 open to internet
# 2) All EBS volumes must be encrypted
# 3) Only available region is US-east-1
# 4) t2.micro-2xLarge
# 5) Block direct policy attachments to individual users
# 6) All resources must be Tagged if possible (at least 6 characters)
########################

# Consider exactly these resource types in calculations
resource_types = {"aws_instance", "aws_iam_policy_attachment", "aws_iam", "aws_security_group", "aws_alb.", "aws_security_group_rule"}
instance_sizes = {"t2.micro", "t2.small", "t2.medium", "t2.large", "t2.2xlarge"}
regions = {"us-east-1"}
ingress_ports = {22, 80, 443}
sg_types = {"aws_security_group", "aws_security_group_rule"}

#########
# Policy
#########

# Authorization holds if score for the plan is acceptable and no changes are made to IAM
default authz = false
authz {
#   not touches_iam
    not iam_user_attachments
    terraform_objects["configuration"]["provider_config"][_]["expressions"]["region"]["constant_value"] == regions[_]
    not incorrect_ec2
    not incorrect_security_groups
    not resources_tagged
}

# Whether there is any change to IAM
touches_iam {
  all := instance_names["aws_iam"]
  count(all) > 0
}

# Whether there is any direct attachments of iam policies to IAM users
iam_user_attachments {
  terraform_objects["planned_values"]["root_module"]["resources"][_]["type"] == "aws_iam_policy_attachment" 
  terraform_objects["planned_values"]["root_module"]["resources"][_]["values"]["users"]
}

correct_instance_size ( size ) {
  instance_sizes[size] 
}

# Check for all the type/sizes of EC2 instances and if EBS volume is unencrypted
incorrect_ec2 {
  resource = terraform_objects["planned_values"]["root_module"]["resources"][_]
  resource["type"] == "aws_instance"
  correct_instance_size(resource["values"]["instance_type"])
  resource["values"]["ebs_block_device"][_]["encrypted"] == false
}

correct_ingress_ports ( ports ) {
  ingress_ports[ports]
}

# Check allowable internet routable ports in security groups
incorrect_security_groups {
  resource = terraform_objects["planned_values"]["root_module"]["resources"][_]
  sg_types[resource["type"]]
  ingress = resource["values"]["ingress"][_]
  not correct_ingress_ports(ingress["to_port"])
  not correct_ingress_ports(ingress["from_port"])
  ingress["cidr_blocks"][_] == "0.0.0.0/0"
}

# Check to see all capable resources are tagged other than null
resources_tagged {
  resource = terraform_objects["planned_values"]["root_module"]["resources"][_]
  # resource["values"]["tags"][_] == "sg-1-int-pa-awg"
  resource["values"]["tags"] == null
}

####################
# Terraform Library
####################

# list of all resources of a given type
instance_names[resource_type] = all {
    some resource_type
    resource_types[resource_type]
    all := [name |
        terraform_objects["configuration"]["root_module"]["resources"][_]["address"] = name
        startswith(name, resource_type)
    ]
}

# Dictionary that maps the instance name to its full object
terraform_objects[name] = obj {
	obj = tfplan[name]
	name != "destroy"
}
