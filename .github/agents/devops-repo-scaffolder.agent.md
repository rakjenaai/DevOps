Yes. I would make the MD file explicitly instruct the Terraform agent to **create the structure first and then implement the Terraform code inside it**, rather than only creating empty files.

# Terraform Infrastructure Repository

## Purpose

This document defines the Terraform repository structure and instructions for implementing Azure infrastructure using Terraform.

The Terraform agent must:

1. Follow the defined directory structure.
2. Create the required Terraform files.
3. Add the appropriate Terraform code to those files based on the infrastructure requirements.
4. Use reusable, production-style Terraform practices.
5. Never create Azure resources directly outside Terraform.

---

# Repository Structure

```text
infra-repo/
└── terraform/
    └── resource-group/
        ├── vnet/
        │   ├── backend.tf
        │   ├── data.tf
        │   ├── main.tf
        │   └── outputs.tf
        │
        ├── subnet/
        │   ├── backend.tf
        │   ├── data.tf
        │   ├── main.tf
        │   └── outputs.tf
        │
        ├── keyvault/
        │   ├── backend.tf
        │   ├── data.tf
        │   ├── main.tf
        │   └── outputs.tf
        │
        ├── acr/
        │   ├── backend.tf
        │   ├── data.tf
        │   ├── main.tf
        │   └── outputs.tf
        │
        ├── aks/
        │   ├── backend.tf
        │   ├── data.tf
        │   ├── main.tf
        │   └── outputs.tf
        │
        ├── vm/
        │   ├── backend.tf
        │   ├── data.tf
        │   ├── main.tf
        │   └── outputs.tf
        │
        └── vmss/
            ├── backend.tf
            ├── data.tf
            ├── main.tf
            └── outputs.tf
```

# Terraform Implementation Instructions

## 1. Add Terraform Code

The structure above is **not only a folder/file placeholder structure**.

When an infrastructure requirement is provided, the Terraform agent must implement the required Terraform code inside the appropriate directory.

For example:

```text
terraform/resource-group/vnet/
```

should contain the Terraform implementation required to create/configure the VNet.

Do not leave the Terraform files empty when implementation requirements are provided.

---

## 2. `backend.tf`

Use `backend.tf` for Terraform state backend configuration.

Example responsibilities:

* Azure Storage Account backend
* State container configuration
* State key configuration
* Environment-specific state separation

Do not hardcode sensitive credentials in `backend.tf`.

---

## 3. `data.tf`

Use `data.tf` for Terraform data sources.

Examples:

* Existing Azure Resource Group
* Existing VNet
* Existing Subnet
* Existing Key Vault
* Existing Resource Provider information
* Existing Azure resources required by the component

Use data sources when an existing Azure resource needs to be referenced instead of recreated.

---

## 4. `main.tf`

Use `main.tf` for the primary Terraform implementation.

This includes:

* Azure resources
* Resource relationships
* Resource configuration
* Dependencies where required

Keep the implementation readable and production-oriented.

---

## 5. `outputs.tf`

Use `outputs.tf` for values that need to be exposed to other Terraform configurations or deployment processes.

Examples:

```text
resource IDs
resource names
VNet ID
subnet IDs
AKS cluster ID
AKS cluster name
ACR ID
Key Vault ID
VM IDs
VMSS ID
```

Do not expose secrets through Terraform outputs.

---


---


---

# Terraform Best Practices

The Terraform implementation must:

* Use the `azurerm` provider where Azure resources are being created.
* Pin Terraform and provider versions where appropriate.
* Use variables for configurable values.
* Use locals for reusable expressions.
* Avoid unnecessary duplication.
* Avoid hardcoded secrets.
* Follow least-privilege principles.
* Use explicit dependencies only when Terraform cannot infer them.
* Keep resources logically separated.
* Use appropriate resource tags.
* Provide useful outputs.
* Keep Terraform code readable and maintainable.

---

# Validation

After adding or modifying Terraform code, validate the configuration.

Run:

```bash
terraform fmt -recursive
```

Then validate each applicable Terraform working directory:

```bash
terraform init -backend=false
terraform validate
```

If a directory has a backend configuration that requires external access, use:

```bash
terraform init -backend=false
```

for syntax/validation checks where appropriate.

The agent should not assume that `terraform plan` or `terraform apply` can be executed successfully without the required Azure credentials, backend configuration, variables, and environment.

---

# Terraform Safety Rules

The Terraform agent must **not**:

* Run `terraform apply`.
* Run `terraform destroy`.
* Create Azure resources directly using Azure CLI.
* Create Azure resources manually through the Azure Portal.
* Store Azure credentials or secrets in Git.
* Hardcode client secrets, passwords, tokens, or certificates.
* Delete existing infrastructure without explicit instruction.
* Modify unrelated Terraform components.

The agent is responsible for generating and validating Terraform code.

Infrastructure deployment must be performed separately through the approved deployment process.

---

# Implementation Workflow

When a new infrastructure requirement is provided, follow this workflow:

```text
1. Understand the infrastructure requirement
             ↓
2. Identify the appropriate component directory
             ↓
3. Check the existing Terraform structure
             ↓
4. Create missing Terraform files if required
             ↓
5. Add Terraform implementation
             ↓
6. Add variables/locals/provider configuration if required
             ↓
7. Add required data sources
             ↓
8. Add outputs
             ↓
9. Format Terraform code
             ↓
10. Validate Terraform configuration
             ↓
11. Report the files created/modified
```

---

# Example

If the requirement is:

```text
Create an Azure VNet with two subnets.
```

The agent should implement the configuration under:

```text
infra-repo/
└── terraform/
    └── resource-group/
        ├── vnet/
        │   ├── backend.tf
        │   ├── data.tf
        │   ├── main.tf
        │   └── outputs.tf
        │
        └── subnet/
            ├── backend.tf
            ├── data.tf
            ├── main.tf
            └── outputs.tf
```

The agent should add the required Terraform resources and configuration to the appropriate files.

It should **not simply create empty `.tf` files**.

---

# Final Requirement

The directory structure provides the **baseline organization**.

The Terraform agent must use that structure to implement the actual infrastructure code whenever an infrastructure requirement is provided.

**Structure first, implementation second, validation before handoff.**
