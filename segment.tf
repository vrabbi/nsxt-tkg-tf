provider "nsxt" {
    host = var.nsx["ip"]
    username = var.nsx["user"]
    password = var.nsx["password"]
    allow_unverified_ssl = true
}

# Create the data sources we will need to refer to later
data "nsxt_policy_transport_zone" "tz" {
    display_name = var.nsx_data_vars["transport_zone"]
}
data "nsxt_policy_tier0_gateway" "t0" {
  display_name = var.nsx_data_vars["t0_router_name"]
}
data "nsxt_policy_edge_cluster" "edge_cluster" {
    display_name = var.nsx_data_vars["edge_cluster"]
}
data "nsxt_policy_segment_security_profile" "security_profile" {
  display_name = var.nsx_data_vars["security_profile"]
}
data "nsxt_policy_spoofguard_profile" "spoofguard_profile" {
  display_name = var.nsx_data_vars["spoofguard_profile"]
}
data "nsxt_policy_tier1_gateway" "t1" {
  display_name = var.nsx_data_vars["t1_router_name"]
}

resource "nsxt_policy_dhcp_server" "test" {
  for_each = var.nsx_resource_vars
  display_name      = each.value["segment_name"]
  description       = "Terraform provisioned DhcpServerConfig for TKG"
  edge_cluster_path = data.nsxt_policy_edge_cluster.edge_cluster.path
  lease_time        = 200
  server_addresses  = [each.value["dhcp_server_address"]]
  
}

resource "nsxt_policy_segment" "segment1" {
  for_each = var.nsx_resource_vars
  display_name        = each.value["segment_name"]
  description         = "Terraform provisioned Segment for TKG"
  connectivity_path   = data.nsxt_policy_tier1_gateway.t1.path
  transport_zone_path = data.nsxt_policy_transport_zone.tz.path
  dhcp_config_path = nsxt_policy_dhcp_server.test[each.key].path
  subnet {
    cidr        = each.value["segment_cidr"]
    dhcp_ranges = [each.value["dhcp_range"]]
    dhcp_v4_config {
      dns_servers = var.dns_server_list
      server_address =  each.value["dhcp_server_address"]
      lease_time     = 36000

    }
  }
  tag {
    scope = "tier"
    tag = each.key
  }
  tag {
    scope = "tkg-cluster"
    tag = var.tkg_cluster_name
  }


  security_profile {
    spoofguard_profile_path = data.nsxt_policy_spoofguard_profile.spoofguard_profile.path
    security_profile_path   = data.nsxt_policy_segment_security_profile.security_profile.path
  }

}

