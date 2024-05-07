# Comm-IT Terraform Module for Google Cloud Organization Policies

This Terraform module is designed to manage organization policies in Google Cloud. It provides a framework for defining and applying various constraints across different resources within a Google Cloud Organization.

## Prerequisites:

- User must be authenticated to the GCP CLI.
- User must have Terraform installed.
- User needs IAM role "Organisation Policy Administrator" on the organization, and IAM role "Editor" on the project. 
- "Organization Policy API" must be enabled on the project.


## Module Components

- org-policies.tf: Defines the Terraform resources for applying organization policies based on a provided YAML configuration.
- main.tf: Configures the Google Cloud provider with necessary project and region details.
- variables.tf: Declares variables for the organization ID, project ID, and region.
- policies.yaml: Contains the policy definitions and configurations to be applied.


## Configuration

### terraform.tfvars File

You need to create a terraform.tfvars file to specify the values for the required variables. This file is not tracked in version control to protect sensitive data. The file should include:

    org_id     = "your-organization-id"
    project_id = "your-project-id"
    region     = "your-region"

Replace "your-organization-id", "your-project-id", and "your-region" with your actual Google Cloud organization ID, project ID, and region.

### Editing the policies.yaml File

The policies.yaml file contains the configurations for the organization policies you wish to enforce or modify. Edit this file according to your needs. Here is a guideline on how to configure the policies:

- Boolean Policies: To enforce a policy (i.e., set to true or false), use the enforce key.
- List Policies: You can specify either allowed values or denied values for each policy, but not both for the same policy. Use allowed_values for whitelisting and denied_values for blacklisting.

Example entries in policies.yaml:

    compute.disableGuestAttributesAccess:
    enforce: true

    iam.allowServiceAccountCredentialLifetimeExtension:
    allowed_values:
        - "allow-example1@example.com"
        - "allow-example2@example.com"

    compute.vmExternalIpAccess:
    denied_values:
        - "projects/org-policies-sandbox/zones/us-central1-c/instances/instance-20240505-131737"

## Usage

### Download the module to your local working directory, and source it locally:
- You need to edit policies.yaml, so it's best to source the module locally, example:
    module "test_policies" {
        source = "PATH/TO/MODULE"

        org_id     = "YOUR_ORG_ID"
        project_id = "YOUR_PROJECT_ID"
        region     = "YOUR_REGION"
    }

### Configure the module:
- As described above, edit the policies.yaml file to apply the policies you want to your organization.

### Initialize Terraform:
- Run terraform init in the directory containing the Terraform configuration files to initialize the working directory.

### Plan the Deployment:
- Execute terraform plan to review the changes that Terraform plans to perform on your Google Cloud resources.

### Apply the Configuration:
- Run terraform apply to apply the changes defined in your Terraform configuration.

## Important Notes

### List Policies: 
- Only one type of list (either allowed_values or denied_values) can be active for a specific policy at a time. Ensure that you do not configure both for a single policy in the policies.yaml file.

### Dynamic Policy Management: 
- The module dynamically constructs organization policies based on the entries in the policies.yaml file. Adjustments to the YAML file will directly affect the policies applied during the next Terraform execution.

By following the above guidelines and configurations, you can efficiently manage your Google Cloud organization's policies using Terraform. Adjust the policies.yaml as required to meet your organization's specific policy needs.

<!-- terraform-docs output will go here -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.27.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_organization_policy.org_policy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The organization ID where the policy will be applied. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Name of a project in the organization. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region of the project. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->