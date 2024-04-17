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

resource "aws_wafv2_web_acl" "wafv2_web_acl_global" {
  provider = aws.global

  name  = var.name
  scope = "CLOUDFRONT"

  dynamic "visibility_config" {
    for_each = var.cloudwatch_metrics_enabled == true ? [1] : []

    content {
      cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
      metric_name                = var.metric_name
      sampled_requests_enabled   = var.sampled_requests_enabled
    }
  }

  dynamic "default_action" {
    for_each = var.default_action == "allow" ? [1] : []

    content {
      allow {}
    }
  }

  dynamic "default_action" {
    for_each = var.default_action == "block" ? [1] : []

    content {
      block {}
    }
  }

  dynamic "rule" {
    for_each = var.rules

    content {
      name     = rule.value["name"]
      priority = rule.value["priority"]

      dynamic "action" {
        for_each = rule.value["action"] == "allow" ? [1] : []

        content {
          allow {}
        }
      }

      dynamic "action" {
        for_each = rule.value["action"] == "block" ? [1] : []

        content {
          block {}
        }
      }

      dynamic "action" {
        for_each = rule.value["action"] == "count" ? [1] : []

        content {
          count {}
        }
      }

      dynamic "statement" {
        for_each = rule.value["statement"]

        content {
          dynamic "managed_rule_group_statement" {
            for_each = rule.value["statement"].managed_rule_group_statement != null ? [1] : []

            content {
              name        = rule.value["statement"].managed_rule_group_statement.name
              vendor_name = rule.value["statement"].managed_rule_group_statement.vendor_name
            }
          }
        }
      }
      # statement = each.statement

      dynamic "override_action" {
        for_each = rule.value["override_action"] == "none" ? [1] : []

        content {
          none {}
        }
      }

      dynamic "override_action" {
        for_each = rule.value["override_action"] == "count" ? [1] : []

        content {
          count {}
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = rule.value["metrics_enabled"]
        metric_name                = rule.value["metric_name"] == null ? rule.value["name"] : rule.value["metric_name"]
        sampled_requests_enabled   = rule.value["sampled_requests_enabled"]
      }
    }
  }

  tags = var.tags
}
