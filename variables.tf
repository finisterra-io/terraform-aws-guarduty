variable "enable_guardduty" {
  description = "Whether to enable GuardDuty."
  type        = bool
  default     = true
}

variable "finding_publishing_frequency" {
  description = "Specifies the frequency of notifications sent about subsequent finding occurrences."
  type        = string
  default     = "SIX_HOURS" # Possible values are FIFTEEN_MINUTES, ONE_HOUR, SIX_HOURS.
}

variable "datasources" {
  description = "A data source configuration for enabling and configuring certain data sources within GuardDuty."
  type = object({
    s3_logs = object({
      enable = optional(bool, false)
    }),
    kubernetes = object({
      audit_logs = object({
        enable = optional(bool, false)
      })
    }),
    malware_protection = object({
      scan_ec2_instance_with_findings = object({
        ebs_volumes = object({
          enable = optional(bool, false)
        })
      })
    })
  })
  default = {
    s3_logs = {
      enable = false
    },
    kubernetes = {
      audit_logs = {
        enable = false
      }
    },
    malware_protection = {
      scan_ec2_instance_with_findings = {
        ebs_volumes = {
          enable = false
        }
      }
    }
  }
}

variable "detector_tags" {
  description = "The tags to be applied to the GuardDuty detector resource."
  type        = map(string)
  default     = {}
}

variable "detector_features" {
  description = "A list of detector features to be managed."
  type = list(object({
    name   = string
    status = string
    additional_configuration = list(object({
      name   = string
      status = string
    }))
  }))
  default = []
}

variable "guardduty_filters" {
  description = "A list of GuardDuty filter configurations."
  type = list(object({
    name             = string
    action           = string
    rank             = number
    description      = string
    tags             = map(string)
    finding_criteria = list(map(any))
  }))
  default = []
}

variable "guardduty_ipsets" {
  description = "A list of GuardDuty IPSet configurations."
  type = list(object({
    activate = bool
    format   = string
    location = string
    name     = string
    tags     = map(string)
  }))
  default = []
}

variable "guardduty_admin_account_id" {
  description = "AWS account identifier to designate as a delegated administrator for GuardDuty. Set to null if not using."
  type        = string
  default     = null
}

variable "enable_guardduty_organization_configuration" {
  description = "Boolean flag to enable or disable creation of the GuardDuty organization configuration."
  type        = bool
  default     = false
}

variable "auto_enable_organization_members" {
  description = "Indicates the auto-enablement configuration of GuardDuty for the member accounts in the organization. Valid values are ALL, NEW, NONE."
  type        = string
  default     = null
}

variable "datasources_s3_logs_auto_enable" {
  description = "Set to true if you want S3 data event logs to be automatically enabled for new members of the organization."
  type        = bool
  default     = false
}

variable "datasources_kubernetes_audit_logs_enable" {
  description = "If true, enables Kubernetes audit logs as a data source for Kubernetes protection."
  type        = bool
  default     = false
}

variable "datasources_malware_protection_ebs_volumes_auto_enable" {
  description = "If true, enables Malware Protection for all new accounts joining the organization."
  type        = bool
  default     = false
}

variable "guardduty_organization_features" {
  description = "A list of GuardDuty organization configuration features."
  type = list(object({
    name        = string
    auto_enable = string
    additional_configuration = list(object({
      name        = string
      auto_enable = string
    }))
  }))
  default = []
}

variable "publishing_destination_arn" {
  description = "The bucket ARN and prefix under which the findings get exported."
  type        = string
  default     = null
}

variable "publishing_destination_kms_key_arn" {
  description = "The ARN of the KMS key used to encrypt GuardDuty findings."
  type        = string
  default     = null
}

variable "publishing_destination_type" {
  description = "The type of the destination for publishing findings. Currently, only 'S3' is available."
  type        = string
  default     = "S3"
}

variable "threatintelset_activate" {
  description = "Specifies whether GuardDuty is to start using the uploaded ThreatIntelSet."
  type        = bool
  default     = null
}

variable "threatintelset_format" {
  description = "The format of the file that contains the ThreatIntelSet. Valid values: TXT, STIX, OTX_CSV, ALIEN_VAULT, PROOF_POINT, FIRE_EYE."
  type        = string
  default     = null
}

variable "threatintelset_location" {
  description = "The URI of the file that contains the ThreatIntelSet."
  type        = string
  default     = null
}

variable "threatintelset_name" {
  description = "The friendly name to identify the ThreatIntelSet."
  type        = string
  default     = null
}

variable "threatintelset_tags" {
  description = "Key-value map of resource tags."
  type        = map(string)
  default     = {}
}
