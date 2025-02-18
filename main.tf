module "resource_group" {
  source                  = "../../../Infraestructure.Core/CAF/resource_group"
  for_each                = { for index, value in var.resource_groups : index => value }
  resource_group_name     = each.value.name
  resource_group_location = each.value.location
  tags                    = var.tags
}

module "spoke_virtual_networks" {
  source                        = "../../../Infraestructure.Core/CAF/virtual_network"
  for_each                      = { for index, value in var.virtual_networks : index => value }
  existing_resource_group_name  = module.resource_group[0].resource_group_name
  virtual_network_name          = each.value.name
  virtual_network_address_space = each.value.address_space
  tags                          = var.tags

  depends_on = [module.resource_group[0]]
}

module "vnet_subnets" {
  source                        = "../../../Infraestructure.Core/CAF/virtual_network/subnets"
  for_each                      = { for index, value in var.subnets : index => value }
  existing_resource_group_name  = module.resource_group[0].resource_group_name
  existing_virtual_network_name = module.spoke_virtual_networks[0].virtual_network_name
  subnet_name                   = each.value.name
  subnet_address_prefixes       = each.value.address_prefixes

  depends_on = [module.resource_group[0], module.spoke_virtual_networks[0]]
}

module "private_dns_zone" {
  source                                 = "../../../Infraestructure.Core/CAF/private_dns_zone"
  for_each                               = { for index, value in var.private_dns_zone : index => value }
  existing_resource_group_name           = module.resource_group[0].resource_group_name
  existing_resource_virtual_network_name = module.spoke_virtual_networks[0].virtual_network_name
  dns_zone_name                          = each.value.name
  tags                                   = var.tags

  depends_on = [module.resource_group[0], module.spoke_virtual_networks[0]]
}

module "storage_account" {
  source                                        = "../../../Infraestructure.Core/CAF/storage_account"
  for_each                                      = { for index, value in var.storage_accounts : index => value }
  storage_account_name                          = each.value.name
  storage_account_replication_type              = each.value.account_replication_type
  storage_account_tier                          = each.value.account_tier
  storage_account_min_tls_version               = each.value.min_tls_version
  storage_account_public_network_access_enabled = each.value.public_network_access_enabled
  storage_account_is_hns_enabled                = each.value.is_hns_enabled
  existing_resource_group_name                  = module.resource_group[0].resource_group_name
  tags                                          = var.tags

  depends_on = [module.resource_group[0]]
}

module "sql_server" {
  source                                       = "../../../Infraestructure.Core/CAF/sql_server"
  for_each                                     = { for index, value in var.sql_servers : index => value }
  sql_server_name                              = each.value.name
  existing_resource_group_name                 = module.resource_group[0].resource_group_name
  azuread_administrator                        = each.value.azuread_administrator
  log_monitoring_enabled                       = each.value.log_monitoring
  retention_days                               = each.value.retention_days
  existing_storage_account_name                = module.storage_account[0].storage_account_name
  existing_storage_account_resource_group_name = module.resource_group[0].resource_group_name
  existing_virtual_network_name                = module.spoke_virtual_networks[0].virtual_network_name
  existing_subnet_name                         = module.vnet_subnets[0].subnet_name
  azuread_administrator_object_id              = each.value.azuread_administrator_object_id
  private_endpoint_sql_server                  = each.value.private_endpoint_sql_server
  firewall_rule                                = each.value.firewall_rule
  tags                                         = var.tags

  depends_on = [module.resource_group[0], module.storage_account[0]]
}


module "sql_server_databases" {
  source                               = "../../../Infraestructure.Core/CAF/sql_server/database"
  for_each                             = { for index, value in var.sql_server_databases : index => value }
  existing_resource_group_name         = module.resource_group[0].resource_group_name
  existing_sql_server_name             = module.sql_server[0].sql_server_name
  sql_server_database_name             = each.value.sql_server_database_name
  sql_server_database_min_capacity     = each.value.min_capacity
  sql_server_database_max_size_gb      = each.value.max_size_gb
  sql_server_database_sku_name         = each.value.sku_name
  sql_server_databases_retention_days  = each.value.retention_days
  sql_server_databases_backup_interval = each.value.backup_interval_in_hours
  auto_pause_delay_in_minutes          = each.value.auto_pause
  sql_server_database_zone_redundant   = each.value.zone_redundant

  tags = var.tags

  depends_on = [module.resource_group[0], module.sql_server[0]]
}

