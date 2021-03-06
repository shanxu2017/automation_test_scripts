variable "controller_admin_password" {}
variable "controller_size" {}
variable "controller_key" {}
variable "controller_name_suffix" {}
variable "controller_admin_email" {}
variable "controller_vpc_cidr_prefix" {}
variable "create_aviatrix_iam_roles" {}
variable "aws_account_number" {}
variable "controller_ami_type" {}
variable "controller_amis" {
  type = "map"
  default = {
    byol = {
      us-east-1 = "ami-db9bb9a1"
      us-east-2 = "ami-b40228d1"
      us-west-1 = "ami-2a7e7c4a"
      us-west-2 = "ami-fd48f885"
      ca-central-1 = "ami-de4bceba"
      eu-central-1 = "ami-a025b9cf"
      eu-west-1 = "ami-830d93fa"
      eu-west-2 = "ami-bc253ed8"
      eu-west-3 = "ami-f8e35585"
      ap-southeast-1 = "ami-0484f878"
      ap-southeast-2 = "ami-34728e56"
      ap-northeast-2 = "ami-d902a2b7"
      ap-southeast-1 = "ami-2a43244c"
      ap-south-1 = "ami-e7560088"
      sa-east-1 = "ami-404c012c"
      us-gov-west-1 = "ami-30890051"
    } 
    metered = {
      us-east-1 = "ami-e099849a"
      us-east-2 = "ami-55face30"
      us-west-1 = "ami-e4010884"
      us-west-2 = "ami-3bca4943"
      ca-central-1 = "ami-b10581d5"
      eu-central-1 = "ami-c12c4dae"
      eu-west-1 = "ami-1770006e"
      eu-west-2 = "ami-ae09ecc9"
      eu-west-3 = "ami-48982e35"
      ap-southeast-1 = "ami-ccd391b0"
      ap-southeast-2 = "ami-73ba7f11"
      ap-northeast-2 = "ami-675af809"
      ap-southeast-1 = "ami-13bec375"
      ap-south-1 = "ami-fe134e91"
      sa-east-1 = "ami-51246d3d"
      us-gov-west-1 = "ami-"
    } 
  } 
}
