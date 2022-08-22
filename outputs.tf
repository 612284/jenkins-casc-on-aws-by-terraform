output "master_public_ip" {
  value = module.jenkins.master_public_ip
}
output "worker_public_ip" {
  value = module.worker.worker_public_ip
}
output "prod_public_ip" {
  value = module.app_server.app_server_public_ip
}
