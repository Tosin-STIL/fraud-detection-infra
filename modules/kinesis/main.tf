resource "aws_kinesis_stream" "fraud_transactions_stream" {
  name             = "${var.project_name}-${var.environment}-fraud-transactions-stream"
  retention_period = 24

  stream_mode_details {
    stream_mode = "ON_DEMAND"
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-fraud-transactions-stream"
    Environment = var.environment
  }
}
