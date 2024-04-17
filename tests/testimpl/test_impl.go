package testimpl

import (
	"context"
	"strconv"
	"testing"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/wafv2"
	waftypes "github.com/aws/aws-sdk-go-v2/service/wafv2/types"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestComposableComplete(t *testing.T, ctx types.TestContext) {
	awsClient := GetAWSWAFV2Client(t)

	t.Run("TestWAFV2ACLExists", func(t *testing.T) {
		awsWAFV2WebACLId := terraform.Output(t, ctx.TerratestTerraformOptions(), "wafv2_web_acl_id")
		awsWAFV2WebACLName := terraform.Output(t, ctx.TerratestTerraformOptions(), "wafv2_web_acl_name")
		awsWAFV2WebACLScope := terraform.Output(t, ctx.TerratestTerraformOptions(), "wafv2_web_acl_scope")
		awsWAFV2WebACLCapacity := terraform.Output(t, ctx.TerratestTerraformOptions(), "wafv2_web_acl_capacity")

		assert.Equal(t, waftypes.Scope(awsWAFV2WebACLScope), waftypes.ScopeCloudfront, "This module only supports WAF ACLs scoped to CLOUDFRONT!")

		expectedCapacity, err := strconv.ParseInt(awsWAFV2WebACLCapacity, 10, 64)
		if err != nil {
			t.Errorf("Failure converting expectedCapacity: %v", err)
		}

		webACL, err := awsClient.GetWebACL(context.TODO(), &wafv2.GetWebACLInput{
			Id:    &awsWAFV2WebACLId,
			Name:  &awsWAFV2WebACLName,
			Scope: waftypes.ScopeCloudfront,
		})
		if err != nil {
			t.Errorf("Failure during GetWebACL: %v", err)
		}

		assert.Equal(t, *webACL.WebACL.Id, awsWAFV2WebACLId, "Expected ID did not match actual ID!")
		assert.Equal(t, webACL.WebACL.Capacity, expectedCapacity, "Expected Capacity type did not match actual Capacity!")
		assert.LessOrEqual(t, webACL.WebACL.Capacity, int64(1500), "Web ACL Capacity is too high and will incur additional monthly costs!")
	})
}

func GetAWSWAFV2Client(t *testing.T) *wafv2.Client {
	awsWAFV2Client := wafv2.NewFromConfig(GetAWSConfig(t))
	return awsWAFV2Client
}

func GetAWSConfig(t *testing.T) (cfg aws.Config) {
	cfg, err := config.LoadDefaultConfig(context.TODO(), config.WithRegion("us-east-1"))
	require.NoErrorf(t, err, "unable to load SDK config, %v", err)
	return cfg
}
