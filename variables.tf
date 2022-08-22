variable "region" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "jenkins_login" {
  type = string
}
variable "jenkins_pass" {
  type = string
}
variable "jenkins_key_name" {
  type = string
}
variable "docker_hub_login" {
  type = string
}
variable "docker_hub_password" {
  type = string
}
variable "docker_hub_repo" {
  type = string
}
variable "worker_user" {
  type = string
}
variable "worker_appserv_key_name" {
  type = string
}
variable "git_hub_token" {
  type = string
}
variable "git_hub_repo_app" {
  type = string
}
variable "git_hub_repo_pipeline" {
  type = string
}
variable "git_hub_repo_web_hook" {
  type = string
}
variable "env" {
  type = string
}
