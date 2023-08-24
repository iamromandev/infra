variable "PROJECT" {
  type = string
}

variable "ENV" {
  type = string
}

variable "DB_SUBNETS" {
  type = list(string)
}

variable "DB_FAMILY" {
  type = string
}

variable "DB_STORAGE_TYPE" {
  type = string
}

variable "DB_ALLOCATED_STORAGE" {
  type = number
}

variable "DB_INSTANCE_CLASS" {
  type = string
}

variable "DB_ENGINE" {
  type = string
}

variable "DB_ENGINE_VERSION" {
  type = string
}

variable "DB_NAME" {
  type = string
}

variable "DB_PORT" {
  type = number
}

variable "DB_USERNAME" {
  type = string
}

variable "DB_PASSWORD" {
  type = string
}

variable "DB_MULTI_AZ" {
  type = bool
}

variable "DB_AVAILABILITY_ZONE" {
  type = string
}

variable "DB_BACKUP_RETENTION_PERIOD" {
  type = number
}

variable "DB_SKIP_FINAL_SNAPSHOT" {
  type = bool
}

variable "DB_PUBLICLY_ACCESSIBLE" {
  type = bool
}

variable "DB_SECURITY_GROUP_IDS" {
  type = list(string)
}


