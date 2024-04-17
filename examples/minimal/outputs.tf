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
  value       = module.wafv2_web_acl_global.wafv2_web_acl_id
}

output "wafv2_web_acl_name" {
  description = "The Name of the WAF WebACL."
  value       = module.resource_names["web_acl"].minimal_random_suffix
}

output "wafv2_web_acl_scope" {
  description = "The Scope of the WAF WebACL."
  value       = module.wafv2_web_acl_global.wafv2_web_acl_scope
}

output "wafv2_web_acl_capacity" {
  description = "Web ACL capacity units (WCUs) currently being used by this web ACL."
  value       = module.wafv2_web_acl_global.wafv2_web_acl_capacity
}
