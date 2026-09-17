module "resource_groups" {
  source          = "../../modules/azurerm_resource_group"
  resource_groups = var.rgs

}

module "storage_accounts" {
  source           = "../../modules/azurerm_storage_account"
  storage_accounts = var.storage_accounts
  depends_on       = [module.resource_groups]
}