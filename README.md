# tf-aws-module_primitive-wafv2_web_acl_global

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

Provides a global (CloudFront) Web ACL for AWS WAFv2. The ACL is created with `scope = CLOUDFRONT` and must be applied through the `aws.global` provider alias in `us-east-1`.

Callers pass a friendly `name`, a `default_action` of `allow` or `block`, and optional WAF rules (managed rule groups by default). CloudWatch metrics and sampled requests can be enabled. This module does not create a CloudFront distribution or a regional Web ACL; for a regional ACL use [tf-aws-module_primitive-wafv2_web_acl_regional](https://github.com/launchbynttdata/tf-aws-module_primitive-wafv2_web_acl_regional).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.100 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.9 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_wafv2_web_acl.wafv2_web_acl_global](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_metrics_enabled"></a> [cloudwatch\_metrics\_enabled](#input\_cloudwatch\_metrics\_enabled) | Whether the WAF sends metrics to CloudWatch. For the list of available metrics, see https://docs.aws.amazon.com/waf/latest/developerguide/waf-metrics.html. | `bool` | `false` | no |
| <a name="input_default_action"></a> [default\_action](#input\_default\_action) | Action to perform if none of the rules contained in the WebACL match. One of `allow`, `block`. | `string` | n/a | yes |
| <a name="input_metric_name"></a> [metric\_name](#input\_metric\_name) | The friendly name of the CloudWatch metric, required if `cloudwatch_metrics_enabled` is True. The name can contain only alphanumeric characters (A-Z, a-z, 0-9) hyphen(-) and underscore (\_), with length from one to 128 characters. It can't contain whitespace or metric names reserved for AWS WAF, for example `All` and `Default_Action`. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Friendly name of the WebACL. Changing this forces creation of a new resource. | `string` | n/a | yes |
| <a name="input_rules"></a> [rules](#input\_rules) | n/a | <pre>list(object(<br/>    {<br/>      name            = string<br/>      priority        = number<br/>      action          = optional(string, null)<br/>      override_action = optional(string, null)<br/>      statement = object({<br/>        managed_rule_group_statement = optional(object({<br/>          name        = string<br/>          vendor_name = optional(string, "AWS")<br/>        }), null)<br/>      })<br/>      metrics_enabled          = optional(bool, true)<br/>      metric_name              = optional(string, null)<br/>      sampled_requests_enabled = optional(bool, false)<br/>    }<br/>  ))</pre> | <pre>[<br/>  {<br/>    "name": "AWSManagedRulesCommonRuleSet",<br/>    "override_action": "none",<br/>    "priority": 0,<br/>    "statement": {<br/>      "managed_rule_group_statement": {<br/>        "name": "AWSManagedRulesCommonRuleSet",<br/>        "vendor_name": "AWS"<br/>      }<br/>    }<br/>  },<br/>  {<br/>    "name": "AWSManagedRulesKnownBadInputsRuleSet",<br/>    "override_action": "none",<br/>    "priority": 10,<br/>    "statement": {<br/>      "managed_rule_group_statement": {<br/>        "name": "AWSManagedRulesKnownBadInputsRuleSet",<br/>        "vendor_name": "AWS"<br/>      }<br/>    }<br/>  },<br/>  {<br/>    "name": "AWSManagedRulesAmazonIpReputationList",<br/>    "override_action": "none",<br/>    "priority": 20,<br/>    "statement": {<br/>      "managed_rule_group_statement": {<br/>        "name": "AWSManagedRulesAmazonIpReputationList",<br/>        "vendor_name": "AWS"<br/>      }<br/>    }<br/>  },<br/>  {<br/>    "name": "AWSManagedRulesAnonymousIpList",<br/>    "override_action": "none",<br/>    "priority": 30,<br/>    "statement": {<br/>      "managed_rule_group_statement": {<br/>        "name": "AWSManagedRulesAnonymousIpList",<br/>        "vendor_name": "AWS"<br/>      }<br/>    }<br/>  },<br/>  {<br/>    "name": "AWSManagedRulesSQLiRuleSet",<br/>    "override_action": "none",<br/>    "priority": 40,<br/>    "statement": {<br/>      "managed_rule_group_statement": {<br/>        "name": "AWSManagedRulesSQLiRuleSet",<br/>        "vendor_name": "AWS"<br/>      }<br/>    }<br/>  },<br/>  {<br/>    "name": "AWSManagedRulesLinuxRuleSet",<br/>    "override_action": "none",<br/>    "priority": 50,<br/>    "statement": {<br/>      "managed_rule_group_statement": {<br/>        "name": "AWSManagedRulesLinuxRuleSet",<br/>        "vendor_name": "AWS"<br/>      }<br/>    }<br/>  },<br/>  {<br/>    "name": "AWSManagedRulesUnixRuleSet",<br/>    "override_action": "none",<br/>    "priority": 60,<br/>    "statement": {<br/>      "managed_rule_group_statement": {<br/>        "name": "AWSManagedRulesUnixRuleSet",<br/>        "vendor_name": "AWS"<br/>      }<br/>    }<br/>  }<br/>]</pre> | no |
| <a name="input_sampled_requests_enabled"></a> [sampled\_requests\_enabled](#input\_sampled\_requests\_enabled) | Whether AWS WAF should store a sampling of the web requests that match the rules. You can view the sampled requests through the AWS WAF console. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of key-value pairs to associate with the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_wafv2_web_acl_application_integration_url"></a> [wafv2\_web\_acl\_application\_integration\_url](#output\_wafv2\_web\_acl\_application\_integration\_url) | The URL to use in SDK integrations with managed rule groups. |
| <a name="output_wafv2_web_acl_arn"></a> [wafv2\_web\_acl\_arn](#output\_wafv2\_web\_acl\_arn) | The ARN of the WAF WebACL. |
| <a name="output_wafv2_web_acl_capacity"></a> [wafv2\_web\_acl\_capacity](#output\_wafv2\_web\_acl\_capacity) | Web ACL capacity units (WCUs) currently being used by this web ACL. |
| <a name="output_wafv2_web_acl_id"></a> [wafv2\_web\_acl\_id](#output\_wafv2\_web\_acl\_id) | The ID of the WAF WebACL. |
| <a name="output_wafv2_web_acl_scope"></a> [wafv2\_web\_acl\_scope](#output\_wafv2\_web\_acl\_scope) | The Scope of the WAF WebACL. |
<!-- END_TF_DOCS -->

## Module Development

### Pre-Requisites

The following commands should be available on your system:

- `asdf` or `mise`
- `make`
- `python3` (for pre-commit)

Additionally, your `git` user and email must be configured. Run the `make configure` command from the root of the repository to ensure that you meet these requirements.

### Pre-Commit hooks

The [.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to Terraform and Golang, as well as some common linting tasks. These will be configured for you when you run `make configure`.

### Local Validation

You should validate the changes you make to any module locally, prior to pushing your changes in a branch to GitHub.

1. Ensure that you have run `make configure` successfully.

2. Ensure you are signed into the appropriate cloud provider (e.g. AWS or Azure) for the module under test in your current console session.

3. Run the Terraform and Golang linters with the following command:

```
make lint
```

4. Once you have satisfied the linters, the following command will build example infrastructure in your configured cloud, run the tests, and then tear down the infrastructure it created:

```
make test
```

The pre-commit validations, as well as the `make lint` and `make test` targets, will all be performed in CI. Running these validations locally prior to opening a PR helps ensure a smooth review and merge process.

### Review & Merge Process

Once your change has been tested locally and your branch pushed up, open a new Pull Request for your branch to the default (main) branch of this repository.

The title of your Pull Request will determine the version bump for this change, and the title must be in [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#specification) format in order to merge. A breaking change will trigger a major version bump, a feature will trigger a minor version bump, and all other types will trigger a patch version bump.

Ensure your CI workflows are passing; seek approval from teammates and address any feedback; seek any explicit approvals required by the CODEOWNERS file. You may merge the PR as soon as all requirements are met, and a new release and tag will be automatically created for you.

### Automatic Updates

The shared configuration and workflow files in this repository are largely managed through the [launch-terraform-skeleton](https://github.com/launchbynttdata/launch-terraform-skeleton) repository. Outside of perhaps the `.gitignore` to account for specific files being generated by certain Terraform modules (e.g. Lambda functions), there should not be much cause to update these files on a per-repo basis, and making changes to them individually is discouraged.

If desired, you can check for and run these updates locally in a branch if you have the `copier` tool installed. Some example commands are included below:

```
# Check for updates, optionally checking prerelease versions
copier check-update [--prereleases]

# Run an update, using default answers if there are any. We use tasks, which requires --trust to be set.
copier update --defaults --trust [--prereleases]

# Recopy from the source, and --overwrite all templated files in the process
copier recopy --defaults --trust --overwrite [--prereleases]
```

Automatic updates will run through a scheduled workflow, and if the post-update tests are successful, the Pull Request created will automatically merge. Conflicts in the update or failures to test may leave a Pull Request outstanding, which needs to be addressed by a Launch Engineer.
