tags = {
  Owner = "DR"
}

virtual_networks = [{
  name          = "vnet-dn-eus2-sbox-evgt"
  address_space = ["10.0.0.1/22"]
}]

resource_groups = [
  {
    name     = "resourcegroup",
    location = "East US 2"
  }
]

subnets = [
  {
    name             = "subnet"
    address_prefixes = ["10.1.0.1/24"]
  }
]

storage_accounts = [
  {
    name                          = "storage"
    account_replication_type      = "GRS"
    account_tier                  = "Standard"
    min_tls_version               = "TLS1_2"
    public_network_access_enabled = true
  }
]

private_dns_zone = [
  {
    name = "privatelink.database.windows.net"
  }
]

sql_servers = [
  {
    name                            = "sqlserver"
    azuread_administrator           = "example@gmail.com"
    azuread_administrator_object_id = "id"
    private_endpoint_sql_server = {
      name                          = "private-endpoint"
      location                      = "East US 2"
      custom_network_interface_name = "nic-private-endpoint"

      private_dns_zone_group = {
        name                 = "privatelink.database.windows.net"
        private_dns_zone_ids = ["privatelink.database.windows.net"]
      }
      private_service_connection = {
        name                 = "sqls-service-connection
        subresource_names    = ["sqlServer"]
        is_manual_connection = "false"
      }
    }
    firewall_rule = {
      name             = "dev-eus2"
      start_ip_address = "10.0.1.1"
      end_ip_address   = "10.0.2.1"
    }
  }
]

sql_server_databases = [
  {
    sql_server_database_name = "database"
    max_size_gb              = 2
    sku_name                 = "GP_S_Gen5_2"
  }
]
