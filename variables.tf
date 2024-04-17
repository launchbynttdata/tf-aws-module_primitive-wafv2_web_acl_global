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

variable "name" {
  description = "Friendly name of the WebACL. Changing this forces creation of a new resource."
  type        = string
}

variable "cloudwatch_metrics_enabled" {
  description = "Whether the WAF sends metrics to CloudWatch. For the list of available metrics, see https://docs.aws.amazon.com/waf/latest/developerguide/waf-metrics.html."
  type        = bool
  default     = false
}

variable "metric_name" {
  description = "The friendly name of the CloudWatch metric, required if `cloudwatch_metrics_enabled` is True. The name can contain only alphanumeric characters (A-Z, a-z, 0-9) hyphen(-) and underscore (_), with length from one to 128 characters. It can't contain whitespace or metric names reserved for AWS WAF, for example `All` and `Default_Action`."
  type        = string
  default     = null

  validation {
    condition     = var.metric_name != null ? can(regex("^[A-Za-z0-9_-]{1,128}$", var.metric_name)) : true
    error_message = "metric_name can contain only alphanumeric characters (A-Z, a-z, 0-9) hyphen(-) and underscore (_), with length from one to 128 characters."
  }
}

variable "sampled_requests_enabled" {
  description = "Whether AWS WAF should store a sampling of the web requests that match the rules. You can view the sampled requests through the AWS WAF console."
  type        = bool
  default     = false
}

variable "default_action" {
  description = "Action to perform if none of the rules contained in the WebACL match. One of `allow`, `block`."
  type        = string

  validation {
    condition     = contains(["allow", "block"], var.default_action)
    error_message = "default_action must be one of allow, block"
  }
}

variable "rules" {
  type = list(object(
    {
      name            = string
      priority        = number
      action          = optional(string, null)
      override_action = optional(string, null)
      statement = object({
        managed_rule_group_statement = optional(object({
          name        = string
          vendor_name = optional(string, "AWS")
        }), null)
      })
      metrics_enabled          = optional(bool, true)
      metric_name              = optional(string, null)
      sampled_requests_enabled = optional(bool, false)
    }
  ))
  default = [
    {
      name            = "AWSManagedRulesCommonRuleSet"
      priority        = 0,
      override_action = "none",
      statement = {
        managed_rule_group_statement = {
          name        = "AWSManagedRulesCommonRuleSet"
          vendor_name = "AWS"
        }
      }
    },
    {
      name            = "AWSManagedRulesKnownBadInputsRuleSet"
      priority        = 10,
      override_action = "none",
      statement = {
        managed_rule_group_statement = {
          name        = "AWSManagedRulesKnownBadInputsRuleSet"
          vendor_name = "AWS"
        }
      }
    },
    {
      name            = "AWSManagedRulesAmazonIpReputationList"
      priority        = 20,
      override_action = "none",
      statement = {
        managed_rule_group_statement = {
          name        = "AWSManagedRulesAmazonIpReputationList"
          vendor_name = "AWS"
        }
      }
    },
    {
      name            = "AWSManagedRulesAnonymousIpList"
      priority        = 30,
      override_action = "none",
      statement = {
        managed_rule_group_statement = {
          name        = "AWSManagedRulesAnonymousIpList"
          vendor_name = "AWS"
        }
      }
    },
    {
      name            = "AWSManagedRulesSQLiRuleSet"
      priority        = 40,
      override_action = "none",
      statement = {
        managed_rule_group_statement = {
          name        = "AWSManagedRulesSQLiRuleSet"
          vendor_name = "AWS"
        }
      }
    },
    {
      name            = "AWSManagedRulesLinuxRuleSet"
      priority        = 50,
      override_action = "none",
      statement = {
        managed_rule_group_statement = {
          name        = "AWSManagedRulesLinuxRuleSet"
          vendor_name = "AWS"
        }
      }
    },
    {
      name            = "AWSManagedRulesUnixRuleSet"
      priority        = 60,
      override_action = "none",
      statement = {
        managed_rule_group_statement = {
          name        = "AWSManagedRulesUnixRuleSet"
          vendor_name = "AWS"
        }
      }
    }
  ]
}

variable "tags" {
  description = "Map of key-value pairs to associate with the resource."
  type        = map(string)
  default     = {}
}
