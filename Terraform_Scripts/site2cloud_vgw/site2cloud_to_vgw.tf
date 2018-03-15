# -Sample Aviatrix terraform configuration to create complete transit VPC solution
# This configuration creates a cloud account on Aviatrix controller, launches transit VPC, creates VGW connection
# with transit VPC
# Launches a spoke GW, and attach with transit VPC.
 
# Create account with IAM roles
resource "aviatrix_account" "temp_account" {
  account_name = "${var.account_name}"
  account_password = "${var.account_password}"
  account_email = "${var.account_email}"
  cloud_type = 1
  aws_account_number = "${var.aws_account_number}"
  aws_access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"
}

resource "aws_vpn_gateway" "vpn_gw" {
  tags {
    Name = "site2cloud-vgw"
  }
  depends_on = ["aviatrix_account.temp_account"]
}
 
#OnPrem-GW
resource "aviatrix_gateway" "OnPrem-GW" {
  cloud_type = 1
  account_name = "${aviatrix_account.temp_account.account_name}"
  gw_name = "OnPrem-GW"
  vpc_id = "${aws_vpc.OnPrem-VPC.id}"
  vpc_reg = "${var.region1}"
  vpc_size = "${var.t2instance}"
  vpc_net = "${aws_subnet.OnPrem-VPC-public.cidr_block}"
}

# Aviatrix site2cloud connection facing AWS VGW
resource "aviatrix_site2cloud" "onprem-vgw" {
  gw_name = "${aviatrix_gateway.OnPrem-GW.gw_name}" 
  vpc_id = "${aws_vpc.OnPrem-VPC.id}",
  conn_name = "${var.conn_name1}",
  remote_gw_type = "AWS VGW",
  remote_gw_ip = "${aws_vpn_connection.onprem.tunnel1_address}",
  remote_subnet = "10.0.0.0/8,172.16.0.0/12,192.168.0.0/16",
  pre_shared_key = "${aws_vpn_connection.onprem.tunnel1_preshared_key}"
  depends_on = ["aviatrix_gateway.OnPrem-GW"]
}

resource "aviatrix_site2cloud" "onprem-vgw-secondary" {
  gw_name = "${aviatrix_gateway.OnPrem-GW.gw_name}"
  vpc_id = "${aws_vpc.OnPrem-VPC.id}",
  conn_name = "${var.conn_name2}",
  remote_gw_type = "AWS VGW",
  remote_gw_ip = "${aws_vpn_connection.onprem.tunnel2_address}",
  remote_subnet = "11.0.0.0/8,173.16.0.0/12,192.169.0.0/16",
  pre_shared_key = "${aws_vpn_connection.onprem.tunnel2_preshared_key}"
  depends_on = ["aviatrix_gateway.OnPrem-GW"]
}


