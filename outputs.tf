# ------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ------------------------------------------------------------------------------

output "address" {
  description = "All compute address attributes."
  value       = try(google_compute_address.address, null)
}

# ------------------------------------------------------------------------------
# OUTPUT ALL INPUT VARIABLES
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT MODULE CONFIGURATION
# ------------------------------------------------------------------------------

output "module_enabled" {
  description = "Whether the module is enabled."
  value       = var.module_enabled
}
