resource "null_resource" "webhook" {

  provisioner "local-exec" {
    command = <<EOH
    curl \
  -X POST \
  -H 'Accept: application/vnd.github+json' \
  -H 'Authorization: token ${var.git_hub_token}' \
  ${var.git_hub_repo_web_hook} \
  -d '{"name":"web","active":true,"events":["push"],"config":{"url":"http://${aws_instance.jenkins.public_ip}:8080/github-webhook/","content_type":"json","insecure_ssl":"0"}}'
EOH
  }

  provisioner "local-exec" {
    when    = destroy
    command = "modules/jenkins/web-hook-delete.sh"
  }
  depends_on = [aws_instance.jenkins]
}
