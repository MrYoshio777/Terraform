variable "tags" {
  type = map(any)
}

variable "resource_groups" {
  type = list(object({
    name     = string
    location = string
  }))
}

variable "virtual_networks" {
  type = list(object({
    name          = string
    address_space = list(string)
  }))
}

variable "subnets" {
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "sql_servers" {
  type = list(object({
    name                            = string
    azuread_administrator           = string
    log_monitoring                  = optional(bool, true)
    retention_days                  = optional(number, 30)
    azuread_administrator_object_id = string
    private_endpoint_sql_server = object({
      name                          = string
      location                      = string
      custom_network_interface_name = string
      private_dns_zone_group = object({
        name                 = string
        private_dns_zone_ids = list(string)
      })

      private_service_connection = object({
        name                 = string
        subresource_names    = list(string)
        is_manual_connection = string
      })
    })
    firewall_rule = object({
      name             = string
      start_ip_address = string
      end_ip_address   = string
    })
  }))
}

variable "sql_server_databases" {
  type = list(object({
    sql_server_database_name = string
    max_size_gb              = number
    sku_name                 = string
    retention_days           = optional(number, 7)
    backup_interval_in_hours = optional(number, 24)
    auto_pause               = optional(number, 60)
    min_capacity             = optional(number, 0.5)
    zone_redundant           = optional(bool, false)
  }))

  description = "The list of sql databases"
}

variable "storage_accounts" {
  type = list(object({
    name                          = string
    account_tier                  = string
    account_replication_type      = string
    min_tls_version               = string
    public_network_access_enabled = bool
    is_hns_enabled                = optional(bool, false)
  }))
}

variable "private_dns_zone" {
  type = list(object({
    name = string
    #Virtual network link de forma manual y es requerido para hacer el attachment al resource
  }))
}

variable "firewall_rule" {

}
