output "worker_key" {
  description = "private_key_pem"
  value       = try(tls_private_key.this.private_key_pem, "")
}
output "worker_public_ip" {
  value = aws_instance.worker.public_ip
}
