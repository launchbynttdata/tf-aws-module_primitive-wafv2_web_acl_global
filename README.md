# tf-aws-module_primitive-wafv2_web_acl_regional

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

Provides a Regional Web ACL for a WAFv2 Resource. To obtain a non-regional (CloudFront) Web ACL, use the global variant, [found here](https://github.com/launchbynttdata/tf-aws-module_primitive-wafv2_web_acl_global).

## Pre-Commit hooks

[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly

- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below

```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. _THIS STEP APPLIES ONLY TO MICROSOFT AZURE. IF YOU ARE USING A DIFFERENT PLATFORM PLEASE SKIP THIS STEP._ The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```

- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitignore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target

- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.global"></a> [aws.global](#provider\_aws.global) | 5.72.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_wafv2_web_acl.wafv2_web_acl_global](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Friendly name of the WebACL. Changing this forces creation of a new resource. | `string` | n/a | yes |
| <a name="input_cloudwatch_metrics_enabled"></a> [cloudwatch\_metrics\_enabled](#input\_cloudwatch\_metrics\_enabled) | Whether the WAF sends metrics to CloudWatch. For the list of available metrics, see https://docs.aws.amazon.com/waf/latest/developerguide/waf-metrics.html. | `bool` | `false` | no |
| <a name="input_metric_name"></a> [metric\_name](#input\_metric\_name) | The friendly name of the CloudWatch metric, required if `cloudwatch_metrics_enabled` is True. The name can contain only alphanumeric characters (A-Z, a-z, 0-9) hyphen(-) and underscore (\_), with length from one to 128 characters. It can't contain whitespace or metric names reserved for AWS WAF, for example `All` and `Default_Action`. | `string` | `null` | no |
| <a name="input_sampled_requests_enabled"></a> [sampled\_requests\_enabled](#input\_sampled\_requests\_enabled) | Whether AWS WAF should store a sampling of the web requests that match the rules. You can view the sampled requests through the AWS WAF console. | `bool` | `false` | no |
| <a name="input_default_action"></a> [default\_action](#input\_default\_action) | Action to perform if none of the rules contained in the WebACL match. One of `allow`, `block`. | `string` | n/a | yes |
| <a name="input_rules"></a> [rules](#input\_rules) | n/a | <pre>list(object(<br>    {<br>      name            = string<br>      priority        = number<br>      action          = optional(string, null)<br>      override_action = optional(string, null)<br>      statement = object({<br>        managed_rule_group_statement = optional(object({<br>          name        = string<br>          vendor_name = optional(string, "AWS")<br>        }), null)<br>      })<br>      metrics_enabled          = optional(bool, true)<br>      metric_name              = optional(string, null)<br>      sampled_requests_enabled = optional(bool, false)<br>    }<br>  ))</pre> | <pre>[<br>  {<br>    "name": "AWSManagedRulesCommonRuleSet",<br>    "override_action": "none",<br>    "priority": 0,<br>    "statement": {<br>      "managed_rule_group_statement": {<br>        "name": "AWSManagedRulesCommonRuleSet",<br>        "vendor_name": "AWS"<br>      }<br>    }<br>  },<br>  {<br>    "name": "AWSManagedRulesKnownBadInputsRuleSet",<br>    "override_action": "none",<br>    "priority": 10,<br>    "statement": {<br>      "managed_rule_group_statement": {<br>        "name": "AWSManagedRulesKnownBadInputsRuleSet",<br>        "vendor_name": "AWS"<br>      }<br>    }<br>  },<br>  {<br>    "name": "AWSManagedRulesAmazonIpReputationList",<br>    "override_action": "none",<br>    "priority": 20,<br>    "statement": {<br>      "managed_rule_group_statement": {<br>        "name": "AWSManagedRulesAmazonIpReputationList",<br>        "vendor_name": "AWS"<br>      }<br>    }<br>  },<br>  {<br>    "name": "AWSManagedRulesAnonymousIpList",<br>    "override_action": "none",<br>    "priority": 30,<br>    "statement": {<br>      "managed_rule_group_statement": {<br>        "name": "AWSManagedRulesAnonymousIpList",<br>        "vendor_name": "AWS"<br>      }<br>    }<br>  },<br>  {<br>    "name": "AWSManagedRulesSQLiRuleSet",<br>    "override_action": "none",<br>    "priority": 40,<br>    "statement": {<br>      "managed_rule_group_statement": {<br>        "name": "AWSManagedRulesSQLiRuleSet",<br>        "vendor_name": "AWS"<br>      }<br>    }<br>  },<br>  {<br>    "name": "AWSManagedRulesLinuxRuleSet",<br>    "override_action": "none",<br>    "priority": 50,<br>    "statement": {<br>      "managed_rule_group_statement": {<br>        "name": "AWSManagedRulesLinuxRuleSet",<br>        "vendor_name": "AWS"<br>      }<br>    }<br>  },<br>  {<br>    "name": "AWSManagedRulesUnixRuleSet",<br>    "override_action": "none",<br>    "priority": 60,<br>    "statement": {<br>      "managed_rule_group_statement": {<br>        "name": "AWSManagedRulesUnixRuleSet",<br>        "vendor_name": "AWS"<br>      }<br>    }<br>  }<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of key-value pairs to associate with the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_wafv2_web_acl_id"></a> [wafv2\_web\_acl\_id](#output\_wafv2\_web\_acl\_id) | The ID of the WAF WebACL. |
| <a name="output_wafv2_web_acl_arn"></a> [wafv2\_web\_acl\_arn](#output\_wafv2\_web\_acl\_arn) | The ARN of the WAF WebACL. |
| <a name="output_wafv2_web_acl_scope"></a> [wafv2\_web\_acl\_scope](#output\_wafv2\_web\_acl\_scope) | The Scope of the WAF WebACL. |
| <a name="output_wafv2_web_acl_application_integration_url"></a> [wafv2\_web\_acl\_application\_integration\_url](#output\_wafv2\_web\_acl\_application\_integration\_url) | The URL to use in SDK integrations with managed rule groups. |
| <a name="output_wafv2_web_acl_capacity"></a> [wafv2\_web\_acl\_capacity](#output\_wafv2\_web\_acl\_capacity) | Web ACL capacity units (WCUs) currently being used by this web ACL. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
