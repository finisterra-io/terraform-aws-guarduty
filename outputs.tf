output "arn" {
  value       = aws_guardduty_detector.this[0].arn
  description = "The ARN of the GuardDuty Detector"
}
