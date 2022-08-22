resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.worker_appserv_key_name
  public_key = tls_private_key.this.public_key_openssh

  ## uncomment this code if you need save private key locally
  # provisioner "local-exec" { # Create "myKey.pem" to your computer!!
  #   command = "echo '${tls_private_key.this.private_key_pem}' > modules/worker/id_rsa"
  # }

}

resource "aws_ssm_parameter" "ssh" {
  name = var.worker_appserv_key_name
  # type  = "String"
  type  = "SecureString"
  value = tls_private_key.this.private_key_pem
}
