variable project {
  description = "Project ID"
}

variable region {
  default     = "europe-west1"
  description = "Project region"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable instance_disk_image {
  default     = "ubuntu-1604-xenial-v20200521"
  description = "Instance OS image used"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable zone {
  default     = "europe-west1-b"
  description = "Project zone"
}

variable env {
  default     = "stage"
  description = "Environment"
}

variable env_label {
  default     = "stage"
  description = "Environment instance label"
}
