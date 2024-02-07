output "arn" {
  value       = aws_guardduty_detector.this.arn
  description = "The ARN of the GuardDuty Detector"
}
