File Name	Purpose		What lives here?
providers.tf	Connection	provider "aws" { ... }
variables.tf	Inputs		variable "my_region" { ... }
data.tf		Searches	data "aws_ami", data "aws_availability_zones"
network.tf	Infrastructure	aws_vpc, aws_subnet, aws_internet_gateway, aws_route_table
security.tf	Firewall	aws_security_group
main.tf		"The "Compute"	aws_instance (The actual servers)
outputs.tf	Results		output "instance_ips"




