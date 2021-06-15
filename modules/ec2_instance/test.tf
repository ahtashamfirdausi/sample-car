data "aws_ssm_document" "foo" {
  name            = "AWS-GatherSoftwareInventory"
  document_format = "JSON"
}

output "content" {
  value = data.aws_ssm_document.foo.content
}