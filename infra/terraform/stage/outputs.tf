output gitlab_ci_external_ip {
  value       = module.gitlab-ci-instance.gitlab_ci_ip
  description = "Access webui ip for gitlab ci"
}
