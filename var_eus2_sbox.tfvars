tags = {
  ApplicationName = "SANBOX"
  StartDate       = "2025-02-06"
  Owner           = "Digital Nest"
  CostCenter      = "ADN-100"
  Env             = "SANBOX"
  CreatedBy       = "deivi.rodriguez@arcacontal.com"
  Project         = "AC_EcosistemaDigital"
}

virtual_networks = [{
  name          = "vnet-dn-eus2-sbox-evgt"
  address_space = ["10.45.200.0/22"]
}]

resource_groups = [
  {
    name     = "rg-sbox-pocdb",
    location = "East US 2"
  }
]

subnets = [
  {
    name             = "snet-dn-sbox-eus2-evgt"
    address_prefixes = ["10.45.200.0/24"]
  }
]

storage_accounts = [
  {
    name                          = "stdnsboxeus2"
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
    name                            = "sqls-dn-sbox-eus2-poc"
    azuread_administrator           = "jesus.alonsos@arcacontal.com"
    azuread_administrator_object_id = "9193ee90-f454-43b9-9615-b5f6f46c4c55"
    private_endpoint_sql_server = {
      name                          = "pep-dn-eus2-endpoint-poc-sbox"
      location                      = "East US 2"
      custom_network_interface_name = "nic-dn-eus2-endpoint-poc-sbox"

      private_dns_zone_group = {
        name                 = "privatelink.database.windows.net"
        private_dns_zone_ids = ["/subscriptions/19810a48-0964-44b7-8503-3f1956714f67/resourceGroups/rg-sbox-pocdb/providers/Microsoft.Network/privateDnsZones/privatelink.database.windows.net"]
      }
      private_service_connection = {
        name                 = "sqls-dn-eus2-sbox-poc"
        subresource_names    = ["sqlServer"]
        is_manual_connection = "false"
      }
    }
    firewall_rule = {
      name             = "AKS-dev-eus2"
      start_ip_address = "20.14.248.28"
      end_ip_address   = "20.14.248.28"
    }
  }
]

sql_server_databases = [
  {
    sql_server_database_name = "db-poc-sbox"
    max_size_gb              = 2
    sku_name                 = "GP_S_Gen5_2"
  }
]
