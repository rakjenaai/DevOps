# Create a Network Security Group
resource "azurerm_network_security_group" "main" {

  # Name of the NSG
  name = "docker-vm-01-nsg"

  # Azure region
  location = "centralindia"

  # Resource group containing the NSG
  resource_group_name = "rg-dev-platform"


  # Allow SSH traffic to the VM
  security_rule {
    # Name of the security rule
    name = "Allow-SSH"

    # Lower number means higher priority
    priority = 100

    # Traffic coming into the VM
    direction = "Inbound"

    # Allow the traffic
    access = "Allow"

    # Use TCP protocol
    protocol = "Tcp"

    # Allow traffic from any source port
    source_port_range = "*"

    # SSH destination port
    destination_port_range = "22"

    # Allow traffic from any source IP
    source_address_prefix = "*"

    # Apply rule to any destination IP
    destination_address_prefix = "*"
  }


  # Allow HTTP traffic to the NGINX container
  security_rule {
    # Name of the security rule
    name = "Allow-HTTP"

    # Priority of this rule
    priority = 110

    # Traffic coming into the VM
    direction = "Inbound"

    # Allow the traffic
    access = "Allow"

    # Use TCP protocol
    protocol = "Tcp"

    # Allow traffic from any source port
    source_port_range = "*"

    # HTTP destination port
    destination_port_range = "80"

    # Allow traffic from any source IP
    source_address_prefix = "*"

    # Apply rule to any destination IP
    destination_address_prefix = "*"
  }


  # Tags for resource identification
  tags = {
    # Environment classification
    Environment = "dev"

    # Terraform manages this resource
    ManagedBy = "Terraform"

    # Project identification
    Project = "docker-compose-lab"
  }
}


# Create a public IP address for the VM
resource "azurerm_public_ip" "main" {

  # Public IP name
  name = "docker-vm-01-pip"

  # Azure region
  location = "centralindia"

  # Resource group containing the public IP
  resource_group_name = "rg-dev-platform"

  # Allocate a fixed public IP
  allocation_method = "Static"

  # Use Standard SKU
  sku = "Standard"


  # Resource tags
  tags = {
    # Environment classification
    Environment = "dev"

    # Terraform manages this resource
    ManagedBy = "Terraform"

    # Project identification
    Project = "docker-compose-lab"
  }
}