rgs = {
  rg1 = {
    name     = "Azadi-preprod"
    location = "Central India"
  }
}

storage_accounts = {
  sa1 = {

    name                     = "sapreprod"
    resource_group_name      = "Storage_Azadi"
    location                 = "Central India"
    account_tier              = "Standard"
    account_replication_type = "LRS"

  }
}