output "gitlab_ci_ip" {
  value = google_compute_instance.gitlab-ci-instance.network_interface[0].access_config[0].nat_ip
}