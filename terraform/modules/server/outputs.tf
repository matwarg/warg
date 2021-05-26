# Outputs

output "public_dns" {
  description = "Public DNS of instance (or DNS of EIP)"
  value       = ip-test-env.public_dns
}