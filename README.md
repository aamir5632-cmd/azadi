# ☁️ Azadi — Azure Infrastructure with Terraform 🚀

[![Terraform](https://img.shields.io/badge/Terraform-1.0+-623CE4?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/Microsoft_Azure-Cloud-0089D6?logo=microsoft-azure&logoColor=white)](https://azure.microsoft.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Infrastructure as Code](https://img.shields.io/badge/IaC-Automated-brightgreen)](#)

A modular, production-ready **Infrastructure-as-Code (IaC)** project powered by **HashiCorp Terraform** to provision and manage Microsoft Azure resources across isolated environments (**Pre-Production** 🧪 and **Production** 🏭).

---

## 📑 Table of Contents

- [🌟 Project Overview](#-project-overview)
- [📂 Repository Structure](#-repository-structure)
- [🏗️ Architecture & Modules](#️-architecture--modules)
  - [📦 1. Resource Group Module](#-1-azurerm_resource_group)
  - [💾 2. Storage Account Module](#-2-azurerm_storage_account)
- [🌐 Environments](#-environments)
- [📋 Prerequisites](#-prerequisites)
- [🚀 Deployment Guide](#-deployment-guide)
  - [1️⃣ Authenticate with Azure](#1️⃣-authenticate-with-azure)
  - [2️⃣ Select Target Environment](#2️⃣-select-target-environment)
  - [3️⃣ Initialize Terraform](#3️⃣-initialize-terraform)
  - [4️⃣ Review Plan](#4️⃣-review-plan)
  - [5️⃣ Deploy Infrastructure](#5️⃣-deploy-infrastructure)
  - [6️⃣ Clean Up / Destroy](#6️⃣-clean-up--destroy)
- [⚙️ Configuration & Variables](#️-configuration--variables)
- [💡 Pro-Tips & Troubleshooting](#-pro-tips--troubleshooting)

---

## 🌟 Project Overview

The **Azadi** repository is built adhering to cloud engineering best practices:

- 🧩 **Reusable Custom Modules**: Modular blocks in `modules/` simplify resource definitions using Terraform's dynamic `for_each` map syntax.
- 🛡️ **Environment Isolation**: Dedicated state boundaries and variable definitions for `preprod` and `prod`.
- 🔗 **Dependency Orchestration**: Built-in `depends_on` relationships ensure parent resources (Resource Groups) are provisioned before child resources (Storage Accounts).

---

## 📂 Repository Structure

```text
azadi/
├── 📄 .gitignore                      # 🙈 Local state, cache, and secrets exclusion rules
├── 📖 README.md                       # 📘 Project documentation & deployment guide
├── 🌐 Environments/                   # 🏢 Environment-specific configurations
│   ├── 🧪 preprod/                    # 🧪 Pre-Production environment
│   │   ├── 📄 main.tf                 # 🔌 Module invocations & dependency wiring
│   │   ├── 📄 provider.tf             # 🔌 Azure provider configuration
│   │   ├── 📄 terraform.tfvars        # 📝 Pre-prod input values
│   │   └── 📄 variable.tf             # 🏷️ Pre-prod variable declarations
│   └── 🏭 prod/                       # 🏭 Production environment
│       ├── 📄 main.tf                 # 🔌 Module invocations & dependency wiring
│       ├── 📄 provider.tf             # 🔌 Azure provider configuration
│       ├── 📄 terraform.tfvars        # 📝 Production input values
│       └── 📄 variable.tf             # 🏷️ Production variable declarations
└── 📦 modules/                        # 🛠️ Reusable Terraform modules
    ├── 📁 azurerm_resource_group/     # 🗂️ Azure Resource Group module
    │   ├── 📄 main.tf                 # ⚙️ Resource definition with for_each
    │   └── 📄 variable.tf             # 📥 Input variables
    └── 📁 azurerm_storage_account/    # 💾 Azure Storage Account module
        ├── 📄 main.tf                 # ⚙️ Resource definition with for_each
        └── 📄 variable.tf             # 📥 Input variables
```

---

## 🏗️ Architecture & Modules

### 📦 1. `azurerm_resource_group`
- **Path**: `modules/azurerm_resource_group/` 📁
- **Purpose**: Dynamically provisions one or more Azure Resource Groups using map iterations.
- **Inputs**:
  - `resource_groups` 🗺️: A map of resource group objects (`name`, `location`).

### 💾 2. `azurerm_storage_account`
- **Path**: `modules/azurerm_storage_account/` 📁
- **Purpose**: Deploys scalable Azure Storage Accounts associated with resource groups.
- **Inputs**:
  - `storage_accounts` 🗺️: A map of storage configurations:
    - `name` 🏷️: Unique storage account identifier (lowercase alphanumeric, 3–24 chars).
    - `resource_group_name` 🗂️: Name of parent Resource Group.
    - `location` 📍: Azure datacenter region (e.g., `Central India`).
    - `account_tier` ⚡: Performance tier (`Standard` / `Premium`).
    - `account_replication_type` 🔁: Redundancy strategy (`LRS`, `GRS`, `ZRS`).

---

## 🌐 Environments

| Environment | Icon | Directory | Target Resource Group | Region 📍 |
| :--- | :---: | :--- | :--- | :--- |
| **Pre-Production** | 🧪 | `Environments/preprod` | `Azadi-preprod` | Central India |
| **Production** | 🏭 | `Environments/prod` | `Azadi-prod` | Central India |

---

## 📋 Prerequisites

Before running Terraform, ensure you have the following tools set up:

- 🛠️ **Terraform CLI** (v1.0.0+):
  ```powershell
  terraform -version
  ```
- 💻 **Azure CLI** (`az`):
  ```powershell
  az --version
  ```
- 🔑 Active **Azure Subscription** with `Contributor` or `Owner` permissions.

---

## 🚀 Deployment Guide

### 1️⃣ Authenticate with Azure

Sign in through the Azure CLI:

```powershell
az login
```

If you manage multiple subscriptions, set the target subscription:

```powershell
az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"
```

Verify your active session:

```powershell
az account show --output table
```

---

### 2️⃣ Select Target Environment

Navigate to the directory of the environment you want to manage:

- **🧪 Pre-Production**:
  ```powershell
  cd Environments/preprod
  ```
- **🏭 Production**:
  ```powershell
  cd Environments/prod
  ```

---

### 3️⃣ Initialize Terraform

Download provider plugins and initialize custom module references:

```powershell
terraform init
```

---

### 4️⃣ Review Plan

Inspect planned infrastructure changes without modifying cloud state:

```powershell
terraform plan
```

---

### 5️⃣ Deploy Infrastructure

Provision your resources into Azure:

```powershell
terraform apply
```
> 💡 *Type `yes` when prompted to approve the execution plan.*

---

### 6️⃣ Clean Up / Destroy

To tear down all resources managed by the current environment when no longer needed:

```powershell
terraform destroy
```

---

## ⚙️ Configuration & Variables

Variables are defined in `variable.tf` and configured in `terraform.tfvars`.

### 📝 Example `terraform.tfvars`:

```hcl
# 🗂️ Resource Groups Map
rgs = {
  rg1 = {
    name     = "Azadi-preprod"
    location = "Central India"
  }
}

# 💾 Storage Accounts Map
storage_accounts = {
  sa1 = {
    name                     = "sapreprod"
    resource_group_name      = "Storage_Azadi"
    location                 = "Central India"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}
```

---

## 💡 Pro-Tips & Troubleshooting

> [!TIP]
> ### 1. 🔌 Azure Provider Configuration
> Both environments use the official `azurerm` provider in `provider.tf`:
> ```hcl
> terraform {
>   required_version = ">= 1.0.0"
>   required_providers {
>     azurerm = {
>       source  = "hashicorp/azurerm"
>       version = "5.5.0"
>     }
>   }
> }
> 
> provider "azurerm" {
>   features {}
> }
> ```

> [!WARNING]
> ### 2. 🔤 Storage Account Naming Constraints
> Azure enforces strict storage account naming rules:
> - Must be **3–24 characters** long.
> - Must contain **only lowercase letters and numbers** (no dashes `-`, underscores `_`, or capital letters).
> - Must be **globally unique** across all of Azure.
> - ✅ *Correct*: `sapreprod`, `saprod` | ❌ *Invalid*: `SA-preprod`, `SA-pod`

> [!NOTE]
> ### 3. 📂 Module Path Matching
> Make sure module source paths in `Environments/*/main.tf` reference the `modules` directory:
> ```hcl
> module "resource_groups" {
>   source          = "../../modules/azurerm_resource_group"
>   resource_groups = var.rgs
> }
> 
> module "storage_accounts" {
>   source           = "../../modules/azurerm_storage_account"
>   storage_accounts = var.storage_accounts
>   depends_on       = [module.resource_groups]
> }
> ```

> [!IMPORTANT]
> ### 4. 🏷️ Variable Key Spelling
> In `terraform.tfvars`, ensure attribute keys match the module definitions:
> - Use `account_tier` (not `accoun_tier`).