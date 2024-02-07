resource "aws_guardduty_detector" "this" {
  enable                       = var.enable_guardduty
  finding_publishing_frequency = var.finding_publishing_frequency
  tags                         = var.detector_tags

  dynamic "datasources" {
    for_each = var.datasources
    content {
      s3_logs {
        enable = lookup(datasources.value.s3_logs, "enable", false)
      }
      kubernetes {
        audit_logs {
          enable = lookup(datasources.value.kubernetes.audit_logs, "enable", false)
        }
      }
      malware_protection {
        scan_ec2_instance_with_findings {
          ebs_volumes {
            enable = lookup(datasources.value.malware_protection.scan_ec2_instance_with_findings.ebs_volumes, "enable", false)
          }
        }
      }
    }
  }
}

resource "aws_guardduty_detector_feature" "this" {
  for_each = { for feature in var.detector_features : feature.name => feature }

  detector_id = aws_guardduty_detector.this.id
  name        = each.value.name
  status      = each.value.status

  dynamic "additional_configuration" {
    for_each = each.value.additional_configuration
    content {
      name   = additional_configuration.value.name
      status = additional_configuration.value.status
    }
  }
}

resource "aws_guardduty_filter" "this" {
  for_each = { for filter in var.guardduty_filters : filter.name => filter }

  name        = each.value.name
  action      = each.value.action
  detector_id = aws_guardduty_detector.this.id
  rank        = each.value.rank
  description = each.value.description
  tags        = each.value.tags

  dynamic "finding_criteria" {
    for_each = each.value.finding_criteria
    content {
      dynamic "criterion" {
        for_each = finding_criteria.value
        content {
          field                 = criterion.value.field
          equals                = lookup(criterion.value, "equals", null)
          not_equals            = lookup(criterion.value, "not_equals", null)
          greater_than          = lookup(criterion.value, "greater_than", null)
          greater_than_or_equal = lookup(criterion.value, "greater_than_or_equal", null)
          less_than             = lookup(criterion.value, "less_than", null)
          less_than_or_equal    = lookup(criterion.value, "less_than_or_equal", null)
        }
      }
    }
  }
}

resource "aws_guardduty_ipset" "this" {
  for_each = { for ipset in var.guardduty_ipsets : ipset.name => ipset }

  activate    = each.value.activate
  detector_id = aws_guardduty_detector.this.id
  format      = each.value.format
  location    = each.value.location
  name        = each.value.name
  tags        = each.value.tags
}

resource "aws_guardduty_organization_admin_account" "this" {
  count = var.guardduty_admin_account_id != null ? 1 : 0

  admin_account_id = var.guardduty_admin_account_id
}



resource "aws_guardduty_organization_configuration" "this" {
  count                            = var.enable_guardduty_organization_configuration ? 1 : 0
  detector_id                      = aws_guardduty_detector.this.id
  auto_enable_organization_members = var.auto_enable_organization_members

  datasources {
    s3_logs {
      auto_enable = var.datasources_s3_logs_auto_enable
    }
    kubernetes {
      audit_logs {
        enable = var.datasources_kubernetes_audit_logs_enable
      }
    }
    malware_protection {
      scan_ec2_instance_with_findings {
        ebs_volumes {
          auto_enable = var.datasources_malware_protection_ebs_volumes_auto_enable
        }
      }
    }
  }
}

resource "aws_guardduty_organization_configuration_feature" "this" {
  for_each = { for feature in var.guardduty_organization_features : feature.name => feature }

  detector_id = aws_guardduty_detector.this.id
  name        = each.value.name
  auto_enable = each.value.auto_enable

  dynamic "additional_configuration" {
    for_each = each.value.additional_configuration
    content {
      name        = additional_configuration.value.name
      auto_enable = additional_configuration.value.auto_enable
    }
  }
}

resource "aws_guardduty_publishing_destination" "this" {
  count           = var.publishing_destination_arn != null ? 1 : 0
  detector_id     = aws_guardduty_detector.this.id
  destination_arn = var.publishing_destination_arn
  kms_key_arn     = var.publishing_destination_kms_key_arn

  destination_type = var.publishing_destination_type
}


resource "aws_guardduty_threatintelset" "this" {
  count       = var.threatintelset_name != null ? 1 : 0
  activate    = var.threatintelset_activate
  detector_id = aws_guardduty_detector.this.id
  format      = var.threatintelset_format
  location    = var.threatintelset_location
  name        = var.threatintelset_name
  tags        = var.threatintelset_tags
}
