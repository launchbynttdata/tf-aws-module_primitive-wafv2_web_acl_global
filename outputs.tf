// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

output "wafv2_web_acl_id" {
  description = "The ID of the WAF WebACL."
  value       = aws_wafv2_web_acl.wafv2_web_acl_global.id
}

output "wafv2_web_acl_arn" {
  description = "The ARN of the WAF WebACL."
  value       = aws_wafv2_web_acl.wafv2_web_acl_global.arn
}

output "wafv2_web_acl_scope" {
  description = "The Scope of the WAF WebACL."
  value       = "CLOUDFRONT"
}

output "wafv2_web_acl_application_integration_url" {
  description = "The URL to use in SDK integrations with managed rule groups."
  value       = aws_wafv2_web_acl.wafv2_web_acl_global.application_integration_url
}

output "wafv2_web_acl_capacity" {
  description = "Web ACL capacity units (WCUs) currently being used by this web ACL."
  value       = aws_wafv2_web_acl.wafv2_web_acl_global.capacity
}
