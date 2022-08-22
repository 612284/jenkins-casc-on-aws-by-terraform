provider "aws" {
  region = var.region
}

module "jenkins" {
  source = "./modules/jenkins"

  region                = var.region
  env                   = var.env
  instance_type         = var.instance_type
  jenkins_login         = var.jenkins_login
  jenkins_pass          = var.jenkins_pass
  jenkins_key_name      = var.jenkins_key_name
  docker_hub_login      = var.docker_hub_login
  docker_hub_password   = var.docker_hub_password
  docker_hub_repo       = var.docker_hub_repo
  worker_user           = var.worker_user
  worker_key            = module.worker.worker_key
  worker_public_ip      = module.worker.worker_public_ip
  git_hub_token         = var.git_hub_token
  git_hub_repo_app      = var.git_hub_repo_app
  git_hub_repo_pipeline = var.git_hub_repo_pipeline
  git_hub_repo_web_hook = var.git_hub_repo_web_hook
  app_server_public_ip  = module.app_server.app_server_public_ip
  depends_on            = [module.app_server, module.worker]
}

module "worker" {
  source = "./modules/worker"

  env                     = var.env
  instance_type           = var.instance_type
  worker_appserv_key_name = var.worker_appserv_key_name
}

module "app_server" {
  source = "./modules/app_server"

  env                     = var.env
  instance_type           = var.instance_type
  worker_appserv_key_name = var.worker_appserv_key_name
  depends_on              = [module.worker]
}
