output "stream_name" {
  description = "Name of the Kinesis stream"
  value       = aws_kinesis_stream.fraud_transactions_stream.name
}
