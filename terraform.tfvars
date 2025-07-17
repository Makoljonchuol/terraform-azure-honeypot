resource_group_name = "honeypot-prod-rg"
location            = "eastus"

# Replace the placeholder below with my actual public IP (e.g. "203.0.113.25/32")
admin_ip            = "YOUR.PUBLIC.IP.ADDRESS/32"

tags = {
  environment = "production"
  owner       = "Makol Johnchuol"
  company     = "Crossrealms International"
}
