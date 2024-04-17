# minimal

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, <= 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_wafv2_web_acl_global"></a> [wafv2\_web\_acl\_global](#module\_wafv2\_web\_acl\_global) | d2lqlh14iel5k2.cloudfront.net/module_primitive/wafv2_web_acl_global/aws | ~> 1.0 |
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | d2lqlh14iel5k2.cloudfront.net/module_library/resource_name/launch | ~> 1.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br>    name       = string<br>    max_length = optional(number, 60)<br>    region     = optional(string, "eastus2")<br>  }))</pre> | <pre>{<br>  "web_acl": {<br>    "max_length": 80,<br>    "name": "acl",<br>    "region": "us-east-1"<br>  }<br>}</pre> | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"apigw"` | no |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | (Required) Environment where resource is going to be deployed. For example. dev, qa, uat | `string` | `"demo"` | no |
| <a name="input_cloudwatch_metrics_enabled"></a> [cloudwatch\_metrics\_enabled](#input\_cloudwatch\_metrics\_enabled) | Whether the WAF sends metrics to CloudWatch. For the list of available metrics, see https://docs.aws.amazon.com/waf/latest/developerguide/waf-metrics.html. | `bool` | `false` | no |
| <a name="input_metric_name"></a> [metric\_name](#input\_metric\_name) | The friendly name of the CloudWatch metric, required if `cloudwatch_metrics_enabled` is True. The name can contain only alphanumeric characters (A-Z, a-z, 0-9) hyphen(-) and underscore (\_), with length from one to 128 characters. It can't contain whitespace or metric names reserved for AWS WAF, for example `All` and `Default_Action`. | `string` | `null` | no |
| <a name="input_sampled_requests_enabled"></a> [sampled\_requests\_enabled](#input\_sampled\_requests\_enabled) | Whether AWS WAF should store a sampling of the web requests that match the rules. You can view the sampled requests through the AWS WAF console. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_wafv2_web_acl_id"></a> [wafv2\_web\_acl\_id](#output\_wafv2\_web\_acl\_id) | The ID of the WAF WebACL. |
| <a name="output_wafv2_web_acl_name"></a> [wafv2\_web\_acl\_name](#output\_wafv2\_web\_acl\_name) | The Name of the WAF WebACL. |
| <a name="output_wafv2_web_acl_scope"></a> [wafv2\_web\_acl\_scope](#output\_wafv2\_web\_acl\_scope) | The Scope of the WAF WebACL. |
| <a name="output_wafv2_web_acl_capacity"></a> [wafv2\_web\_acl\_capacity](#output\_wafv2\_web\_acl\_capacity) | Web ACL capacity units (WCUs) currently being used by this web ACL. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
