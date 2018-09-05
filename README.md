# Chef

A cookbook of Chef recipes for the Trend Micro Deep Security Agent. The recipes allow you to easily deploy the Deep Security Agent and perform a few common agent tasks.

## Support

This is a community project that is supported by the Deep Security team.

Tutorials, feature-specific help, and other information about Deep Security is available from the [Deep Security Help Center](https://help.deepsecurity.trendmicro.com/Welcome.html). 

For Deep Security specific issues, please use the regular Trend Micro support channels. For issues with the code in this repository, please [open an issue here on GitHub](https://github.com/deep-security/chef/issues).

## OpsWorks

This repository is also setup for use from [AWS OpsWorks](https://aws.amazon.com/opsworks/). You can enable this as a *custom cookbook* within your stack. This makes is very easy to ensure that the Deep Security Agent is running on all of the EC2 instances within your stack.

To enable a custom cookbook:

1. From within your stack, click the "Stack Settings" button.
1. On the stack setting page, click the blue "Edit" button.
1. Slide the "Use custom Chef cookbooks" toggle to "Yes".
1. Set the input fields as follow:
	- "Repository type": *git*
	- "Repository URL": *https://github.com/tsheth/chef.git*
1. Click the blue "Save" button.
1. On the "Deployments" page for your stack, click the gray "Run Command" button.

If you have existing instances running, do the following:

1. Select "Update Custom Cookbooks" from the "Command" drop-down.
1. Click the blue, "Update Custom Cookbooks" button to run the command.

In the Layers section of the OpsWorks Management Console, for your layer;

1. Click Recipes.
1. Under "Custom Recipes", in the "*Configuration*" life cycle enter **deep-security-agent::default**.
1. Click the General Settings section.
1. In the "Custom JSON" section, enter the necessary recipe settings.

The recipe settings will be along the lines of:
### For Deep security as a service deployment:
Recipe : deep-security-agent::default
```javascript
{
  "deep_security_agent" : {
    "dsm_agent_download_hostname": "app.deepsecurity.trendmicro.com",
    "dsm_agent_download_port" : "443",
    "dsm_agent_activation_hostname" : "agents.deepsecurity.trendmicro.com",
    "dsm_agent_activation_port" : "443",
    "tenant_id" : "<Deep Security DSAAS Tenant ID>",
    "token" : "<Deep Security DSAAS Tenant Token>"
  }
}
```
### For DSM deployments:
Recipe : deep-security-agent::dsa-install
```
{
  "deep_security_agent" : {
    "dsm_agent_download_hostname": "<DSM server domain>",
    "dsm_agent_download_port" : "443",
	"ignore_ssl_validation" : "true"
  }
}
```

Recipe : deep-security-agent::dsa-activate
```
{
  "deep_security_agent" : {
    "dsm_agent_activation_hostname" : "<DSM server domain>",
    "dsm_agent_activation_port" : "4120",
	"policy_id" : "1",
	"force_reactivation" : "true"
  }
}
```
The recipes within this repo are now available to you from within your AWS OpsWorks stack.



### Multiple custom cookbooks

**--This technique is still being tested--**

Since AWS OpsWorks only allows one custom cookbook per stack. You have to do a little extra work if you want to incorporate multiple custom cookbooks. Thankfully, git makes this easy. 

1. Create a new repo that you will use as your custom cookbook.
1. Add each cookbook you want to use as a [```git submodule```](http://git-scm.com/docs/git-submodule).
1. Create a symbolic link to the recipe at the top level of the new repo (```ln -s clone/recipe recipe```).

This will keep each of the customer cookbook in its own git repo but allow you to point OpsWorks to one place.

## How to contribute

We're always open to PRs from the community. To submit one:

1. Fork the repo.
1. Create a new feature branch.
1. Make your changes.
1. Submit a PR with an explanation of your changes or additions.

We'll review and work with you to make sure that the fix gets pushed out quickly. For further help, please contact the Trend Micro open source support team at deepsecurityopensource@trendmicro.com.
