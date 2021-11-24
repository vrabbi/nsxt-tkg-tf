nsx = {
    ip  = "nsxt-mgmt-vip.terasky.local"
    user = "admin"
    password = "<CHANGE ME>"
}
nsx_data_vars = {
    transport_zone  = "OVERLAY-TZ"
    t0_router_name = "T0-Policy"
    edge_cluster = "edge-cls-policy"
    t1_router_name = "Scott-TKG-Routable"
    security_profile = "allow_all"
    spoofguard_profile = "default-spoofguard-profile"
}
nsx_resource_vars = {
    app ={
        segment_name = "app-tkg-01"
        segment_cidr = "10.110.1.1/24"
        dhcp_range = "10.110.1.3-10.110.1.200"
        dhcp_server_address = "10.110.1.2/24"
    }
    db = {
        segment_name = "db-tkg-01"
        segment_cidr = "10.110.2.1/24"
        dhcp_range = "10.110.2.3-10.110.2.200"
        dhcp_server_address = "10.110.2.2/24"
    }
    web = {
        segment_name = "web-tkg-01"
        segment_cidr = "10.110.3.1/24"
        dhcp_range = "10.110.3.3-10.110.3.200"
        dhcp_server_address = "10.110.3.2/24"
    }
    mgmt = {
        segment_name = "mgmt-tkg-01"
        segment_cidr = "10.110.4.1/24"
        dhcp_range = "10.110.4.3-10.110.4.200"
        dhcp_server_address = "10.110.4.2/24"
    }
    orilan = {
        segment_name = "orilan-tkg-01"
        segment_cidr = "10.110.5.1/24"
        dhcp_range = "10.110.5.3-10.110.5.200"
        dhcp_server_address = "10.110.5.2/24"
    }
}
tkg_cluster_name = "test-tkg-02-payoneer"
dns_server_list = ["172.16.20.10", "8.8.8.8"]
