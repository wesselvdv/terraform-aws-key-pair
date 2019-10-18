output "key_name" {
  value       = join("", aws_key_pair.generated.*.key_name)
  description = "Name of SSH key"
}

output "public_key" {
  value       = join("", tls_private_key.default.*.public_key_openssh)
  description = "Content of the generated public key"
}

output "private_key" {
  value       = join("", tls_private_key.default.*.private_key_pem)
  description = "Content of the generated private key"
}
