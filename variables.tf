variable "nsx" {
    type = map
    description = "NSX Login Details"
}
variable "nsx_data_vars" {
    type = map
    description = "Existing NSX vars for data sources"
}
variable "nsx_resource_vars" {
    type = map
    description = "NSX vars for the resources"
}
variable "dns_server_list" {
    type = list
    description = "DNS Servers"
}
variable "tkg_cluster_name" {
    type = string
}
