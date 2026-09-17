rgs = {
  rg1 = {
    name     = "Azadi-prod"
    location = "Central India"
  }
  rg2 = {
    name     = "aprod"
    location = "Central India"
  }
}

storage_accounts = {
  sa1 = {
    name                     = "saaprod"
    resource_group_name      = "Storage_Azadi"
    location                 = "Central India"
    accoun_tier              = "Standard"
    account_replication_type = "LRS"

  }
}
