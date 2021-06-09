output "private_key" {
  description = "Random generated key."
  value       = tls_private_key.exampleapp.private_key_pem
  sensitive   = true
}
