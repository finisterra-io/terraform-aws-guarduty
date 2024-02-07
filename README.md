
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.29 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.29 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_guardduty_detector.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_detector) | resource |
| [aws_guardduty_detector_feature.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_detector_feature) | resource |
| [aws_guardduty_filter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_filter) | resource |
| [aws_guardduty_ipset.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_ipset) | resource |
| [aws_guardduty_organization_admin_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_organization_admin_account) | resource |
| [aws_guardduty_organization_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_organization_configuration) | resource |
| [aws_guardduty_organization_configuration_feature.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_organization_configuration_feature) | resource |
| [aws_guardduty_publishing_destination.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_publishing_destination) | resource |
| [aws_guardduty_threatintelset.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_threatintelset) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_enable_organization_members"></a> [auto\_enable\_organization\_members](#input\_auto\_enable\_organization\_members) | Indicates the auto-enablement configuration of GuardDuty for the member accounts in the organization. Valid values are ALL, NEW, NONE. | `string` | `null` | no |
| <a name="input_datasources"></a> [datasources](#input\_datasources) | A data source configuration for enabling and configuring certain data sources within GuardDuty. | <pre>object({<br>    s3_logs = object({<br>      enable = optional(bool, false)<br>    }),<br>    kubernetes = object({<br>      audit_logs = object({<br>        enable = optional(bool, false)<br>      })<br>    }),<br>    malware_protection = object({<br>      scan_ec2_instance_with_findings = object({<br>        ebs_volumes = object({<br>          enable = optional(bool, false)<br>        })<br>      })<br>    })<br>  })</pre> | <pre>{<br>  "kubernetes": {<br>    "audit_logs": {<br>      "enable": false<br>    }<br>  },<br>  "malware_protection": {<br>    "scan_ec2_instance_with_findings": {<br>      "ebs_volumes": {<br>        "enable": false<br>      }<br>    }<br>  },<br>  "s3_logs": {<br>    "enable": false<br>  }<br>}</pre> | no |
| <a name="input_datasources_kubernetes_audit_logs_enable"></a> [datasources\_kubernetes\_audit\_logs\_enable](#input\_datasources\_kubernetes\_audit\_logs\_enable) | If true, enables Kubernetes audit logs as a data source for Kubernetes protection. | `bool` | `false` | no |
| <a name="input_datasources_malware_protection_ebs_volumes_auto_enable"></a> [datasources\_malware\_protection\_ebs\_volumes\_auto\_enable](#input\_datasources\_malware\_protection\_ebs\_volumes\_auto\_enable) | If true, enables Malware Protection for all new accounts joining the organization. | `bool` | `false` | no |
| <a name="input_datasources_s3_logs_auto_enable"></a> [datasources\_s3\_logs\_auto\_enable](#input\_datasources\_s3\_logs\_auto\_enable) | Set to true if you want S3 data event logs to be automatically enabled for new members of the organization. | `bool` | `false` | no |
| <a name="input_detector_features"></a> [detector\_features](#input\_detector\_features) | A list of detector features to be managed. | <pre>list(object({<br>    name   = string<br>    status = string<br>    additional_configuration = list(object({<br>      name   = string<br>      status = string<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_detector_tags"></a> [detector\_tags](#input\_detector\_tags) | The tags to be applied to the GuardDuty detector resource. | `map(string)` | `{}` | no |
| <a name="input_enable_guardduty"></a> [enable\_guardduty](#input\_enable\_guardduty) | Whether to enable GuardDuty. | `bool` | `true` | no |
| <a name="input_enable_guardduty_organization_configuration"></a> [enable\_guardduty\_organization\_configuration](#input\_enable\_guardduty\_organization\_configuration) | Boolean flag to enable or disable creation of the GuardDuty organization configuration. | `bool` | `false` | no |
| <a name="input_finding_publishing_frequency"></a> [finding\_publishing\_frequency](#input\_finding\_publishing\_frequency) | Specifies the frequency of notifications sent about subsequent finding occurrences. | `string` | `"SIX_HOURS"` | no |
| <a name="input_guardduty_admin_account_id"></a> [guardduty\_admin\_account\_id](#input\_guardduty\_admin\_account\_id) | AWS account identifier to designate as a delegated administrator for GuardDuty. Set to null if not using. | `string` | `null` | no |
| <a name="input_guardduty_filters"></a> [guardduty\_filters](#input\_guardduty\_filters) | A list of GuardDuty filter configurations. | <pre>list(object({<br>    name             = string<br>    action           = string<br>    rank             = number<br>    description      = string<br>    tags             = map(string)<br>    finding_criteria = list(map(any))<br>  }))</pre> | `[]` | no |
| <a name="input_guardduty_ipsets"></a> [guardduty\_ipsets](#input\_guardduty\_ipsets) | A list of GuardDuty IPSet configurations. | <pre>list(object({<br>    activate = bool<br>    format   = string<br>    location = string<br>    name     = string<br>    tags     = map(string)<br>  }))</pre> | `[]` | no |
| <a name="input_guardduty_organization_features"></a> [guardduty\_organization\_features](#input\_guardduty\_organization\_features) | A list of GuardDuty organization configuration features. | <pre>list(object({<br>    name        = string<br>    auto_enable = string<br>    additional_configuration = list(object({<br>      name        = string<br>      auto_enable = string<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_publishing_destination_arn"></a> [publishing\_destination\_arn](#input\_publishing\_destination\_arn) | The bucket ARN and prefix under which the findings get exported. | `string` | `null` | no |
| <a name="input_publishing_destination_kms_key_arn"></a> [publishing\_destination\_kms\_key\_arn](#input\_publishing\_destination\_kms\_key\_arn) | The ARN of the KMS key used to encrypt GuardDuty findings. | `string` | `null` | no |
| <a name="input_publishing_destination_type"></a> [publishing\_destination\_type](#input\_publishing\_destination\_type) | The type of the destination for publishing findings. Currently, only 'S3' is available. | `string` | `"S3"` | no |
| <a name="input_threatintelset_activate"></a> [threatintelset\_activate](#input\_threatintelset\_activate) | Specifies whether GuardDuty is to start using the uploaded ThreatIntelSet. | `bool` | `null` | no |
| <a name="input_threatintelset_format"></a> [threatintelset\_format](#input\_threatintelset\_format) | The format of the file that contains the ThreatIntelSet. Valid values: TXT, STIX, OTX\_CSV, ALIEN\_VAULT, PROOF\_POINT, FIRE\_EYE. | `string` | `null` | no |
| <a name="input_threatintelset_location"></a> [threatintelset\_location](#input\_threatintelset\_location) | The URI of the file that contains the ThreatIntelSet. | `string` | `null` | no |
| <a name="input_threatintelset_name"></a> [threatintelset\_name](#input\_threatintelset\_name) | The friendly name to identify the ThreatIntelSet. | `string` | `null` | no |
| <a name="input_threatintelset_tags"></a> [threatintelset\_tags](#input\_threatintelset\_tags) | Key-value map of resource tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the GuardDuty Detector |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
