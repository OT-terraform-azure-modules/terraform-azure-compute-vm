# terraform-azure-compute-vm

This module is designed to provision the complete compute setup comprising of the below components

```
- Multiple NICs in the specified Subnets based on the user inputs
- Multiple Linux VMs based on the user inputs
```

## Usage

- To use the module refer the `Example` directory which highlights the complete usage of the module.
- Refer to the branch `v1.0.0` in your environment to use the stable version of the module `git::https://github.com/OT-terraform-azure-modules/terraform-azure-compute-vm?ref=v1.0.0`
- The below inputs are required for the module to run:
    - resource_group_name: String value for the name of the existing resource group
    - network_interfaces: Map of objects comprising of the NIC details to be created
        - Example:
            ```
            network_interfaces = {
              qa-scalenut-nic = {
                name      = "qa-scalenut-nic"
                subnet_id = "<subnet_id_obtained post the network skeleton execution>"
              }
              qa-webtube-nic = {
                name      = "qa-webtube-nic"
                subnet_id = "<subnet_id_obtained post the network skeleton execution>"
              }
              qa-kefi-nic = {
                name      = "qa-kefi-nic"
                subnet_id = "<subnet_id_obtained post the network skeleton execution>"
              }
              qa-mysql-nic = {
                name      = "qa-mysql-nic"
                subnet_id = "<subnet_id_obtained post the network skeleton execution>"
              }
              qa-mongo-nic = {
                name      = "qa-mongo-nic"
                subnet_id = "<subnet_id_obtained post the network skeleton execution>"
              }
            }
            ```
    - virtual_machines: Map of objects comprising of the NIC details to be created
        ```
        virtual_machines = {
          qa-scalenut-vm = {
            name           = "qa-scalenut-vm"
            size           = "Standard_B2s"
            admin_username = "azureuser"
            nic_name        = "qa-scalenut-nic"
            ssh_key_path = "~/.ssh/id_rsa.pub"
          }
          qa-mysql-vm = {
            name           = "qa-mysql-vm"
            size           = "Standard_B2s"
            admin_username = "azureuser"
            nic_name        = "qa-mysql-nic"
            ssh_key_path = "~/.ssh/id_rsa.pub"
          }
        }
        ```
- The backend will be stored in the stroage account in Azure, the backend details are mentioned in the `backend.tf`
- In your environment to avoid the remote state overriding due to multiple module execution create a terraform workspace to keep the module execution segregatged.
- Create a new terraform workspace: `terraform workspace new compute`
- Verify the newly created compute workspace is currently being used `terraform workspace show` 
- Execute `terraform init` to initialize the module and the remote backend.
- Then execute `terraform plan` to list the implementation dry run.
- Then execute `terraform apply` to deploy the network skeleton.
- Once the execution is successful the compute resources would be provisioned in the environment.