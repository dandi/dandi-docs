# Initialize Vendor Accounts

The DANDI ecosystem relies on vendor services to operate.  So first you will need to set up accounts with the following vendors:

- **Heroku**: Provisions the API components.
- **AWS**: Provides storage buckets (S3), as well as domain management (Route53), for resources across the DANDI ecosystem. As well as the services (EC2, Kubernetes, etc.) for deploying the JupyterHub.
- **GitHub**: Serves as the authentication provider for accounts across the DANDI ecosystem.
- **Terraform Cloud**: Manages provisioned resources across cloud vendors in a version-controlled manner. 
- **Netlify**: Deploys production frontend build, as well as staging previews to assist with frontend development.
- **Sentry**: Provides observability and monitoring for API events.

Some services are not yet integrated within the main infrastructure:

• https://github.com/dandi/backups2datalad - to populate/update https://github.com/dandi/dandisets, https://github.com/dandisets, and https://github.com/dandizarrs/

## Heroku

##### Create your own Heroku account

No special steps here, just create!

##### Create a "Team" 

Send invites to the appropriate e-mail addresses to onboard your team

##### Create an "App"

<br/><br/>
<img
src="../../../img/heroku_create_app.jpg"
alt="heroku_create_app"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

You can name whatever you wish -- no need to add a pipeline, etc. **Be sure to note the app name**

<br/><br/>
<img
src="../../../img/heroku_app_name.jpg"
alt="heroku_app_name"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

Your app will be an empty template, but that is OK -- more to come here!

##### Obtain Heroku API Key

You'll need to provide access to Heroku for GitHub, Terraform, etc. -- thus, you'll need to generate an API Key

First go to your `Account Settings`:

<br/><br/>
<img
src="../../../img/heroku_account_settings.jpg"
alt="heroku_app_name"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

Next, find the `API Key` section and generate a new key.

<br/><br/>
<img
src="../../../img/heroku_key.jpg"
alt="heroku_app_name"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

Keep this value for further steps.

## AWS

##### Create your organization's AWS account

No special steps here, just create!


##### Create an IAM User Group with `AdministratorAccess`

<br/><br/>
<img
src="../../../img/user_group.jpg"
alt="user_group"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

Ensure that you click the right policy in the `Attach permissions policies` section.

<br/><br/>
<img
src="../../../img/permissions.jpg"
alt="permissions"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

**Note: If you know more refined permissions to give the IAM Group, that is preferred, as those with access
to the credentials of `AdministratorAccess` in AWS can be an extreme security hazard if not managed appropriately**

<br/><br/>
<img
src="../../../img/create_group.jpg"
alt="create_group"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>


##### Create an IAM user that lives in the User Group you made

<br/><br/>
<img
src="../../../img/create_user.jpg"
alt="create_user"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

Next, give a unique name -- no need to enable Console Access

<br/><br/>
<img
src="../../../img/specify_user.jpg"
alt="specify_user"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

Lastly, add them to the Group you made in the step above:

<br/><br/>
<img
src="../../../img/add_perms.jpg"
alt="add_perms"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

##### Create security credentials

You'll need to create `Security Credentials` for your User -- these credentials will be specifically used
in your `Terraform Cloud` setup

Firstly, go to your User and click the `Security Credentials` tab:

<br/><br/>
<img
src="../../../img/creds.jpg"
alt="creds"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>

Navigate to `Create access key`

<br/><br/>
<img
src="../../../img/access_key.jpg"
alt="access_key"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

You'll be prompted to provide a reason for the access key creation. It doesn't matter much, so `Other` is a completely acceptable choice

<br/><br/>
<img
src="../../../img/creds_purpose.jpg"
alt="creds_purpose"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

Time to create the key!

<br/><br/>
<img
src="../../../img/create_tag.jpg"
alt="create_tag"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

You'll be provided with the values of your `Access key` and `Secret access key` -- store these values somewhere secure and accessible

<br/><br/>
<img
src="../../../img/retrieve.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

## GitHub

You'll need to create a GitHub Organization where you can fork the DANDI repositories. [See here for documentation to create a GitHub organization](https://docs.github.com/en/organizations/collaborating-with-groups-in-organizations/creating-a-new-organization-from-scratch)

##### Initialize your OAuth App

Once you create the Organization, navigate to the `Settings` tab:

<br/><br/>
<img
src="../../../img/github_home.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

Under `Settings`, you'll want to initialize an `OAuth App` -- navigate to `Developer settings > OAuth Apps`

<br/><br/>
<img
src="../../../img/oauth_app.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

Click on `New Org OAuth App` next

<br/><br/>
<img
src="../../../img/new_app.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

You'll be prompted with the following form -- see the example values populated in this screenshot -- more to come in other sections for where these values might be populated:

<br/><br/>
<img
src="../img/register_new_oauth.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

##### Obtaining your OAuth App Credentials

After creating your OAuth App, you'll lastly want to obtain a client secret key and your client ID -- make sure to note these values for further steps when creating your API.
<br/><br/>
<img
src="../../../img/client_values.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

##### Connecting GitHub with Heroku

**This step is contingent that you have forked [dandi-archive](https://github.com/dandi/dandi-archive)**

Once you have the repository forked, you'll want to navigate to `Settings` in the repository page:

<br/><br/>
<img
src="../../../img/linc_settings.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

Next, navigate to `Security > Secrets and variables > Actions`

<br/><br/>
<img
src="../../../img/secrets_actions.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

And then lastly create two new secrets, `HEROKU_EMAIL` should be the email address/account you used to generate your `HEROKU_API_KEY`

<br/><br/>
<img
src="../../../img/heroku_secrets.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

## Terraform Cloud

Terraform is configuration tool for managing "infrastructure-as-code" -- meaning that we can programmatically manage infrastructure in
a traceable, version-controlled form.

The Terraform ecosystem provides a UI tool called **Terraform Cloud**.

Start by visiting `https://app.terraform.io/` and making an account.

##### Creating a Terraform Project and Workspace

Once you have successfully made an account, you'll want to create a `Workspace` and a `Project` in that `Workspace`

<br/><br/>
<img
src="../../../img/terraform_init.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

##### Populate Environment Variables

Populate the following variables in the `Variables` section of the `Workspace`:

1. `AWS_ACCESS_KEY_ID`
2. `AWS_SECRET_ACCESS_KEY`
3. `HEROKU_API_KEY`
4. `HEROKU_EMAIL`

<br/><br/>
<img
src="../../../img/terraform_vars.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

##### Link GitHub Repository

Next, link your appropriate GitHub repository, in this case, most likely your fork of [dandi-infrastructure](https://github.com/dandi/dandi-infrastructure).

<br/><br/>
<img
src="../../../img/tf_vcs.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

Link your repository -- you may need to declare the appropriate subdirectory 

<br/><br/>
<img
src="../../../img/tf_repo.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

You can now invoke Terraform `plan` and `apply` from the Terraform Cloud UI or via your GitHub repository Actions.

## Netlify

The frontend for `dandi-archive` is served via [Netlify](https://www.netlify.com/)

**Note:** A `Starter` plan should be plenty enough (specifically "build minutes" shouldn't exceed much past ~300 at most a month)
-- if you'd like more control over specific deployments and environments, you
may want to consider `Pro` -- [see here for more details](https://www.netlify.com/pricing/)

##### Create Account and Initialize Project

First, create an account. After creating an account, you'll want to navigate to `Sites`, where you can `Add a new site`, and then `Import an existing project`

<br/><br/>
<img
src="../../../img/start_netlify.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

You'll want to next connect `dandi-archive` via `Deploy with GitHub`. Enable Netlify to be authorized as a GitHub app. Once you have
enabled authorization, you'll need to specifically link your appropriate repositories:

<br/><br/>
<img
src="../../../img/netlify_auth.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

Now once you see the appropriate repository, you'll want to navigate to configure where Netlify can find and build your site

<br/><br/>
<img
src="../../../img/netlify_repo_search.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

For usage of Netlify, one could refer to declaring a `netlify.toml` configuration file [like the one referenced in DANDI Archive](https://github.com/dandi/dandi-archive/blob/master/web/netlify.toml)

These values can also be replicated in the settings. 

<br/><br/>
<img
src="../../../img/netlify_config.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

Your frontend should be able to deploy to an auto-generated URL via Netlify now! Steps for domain management and configuration are described further in the [Frontend Deployment](./dandi-archive.md#frontend-deployment) section within the DANDI Archive setup.
## Sentry

[Sentry](https://sentry.io/) is a monitoring tool used for the DANDI Archive API. It is integral in order to notify engineers if a system is down, experiencing poor performance, or may have unwanted users.

Begin by creating a Sentry account -- once successful, you'll start by creating a new Project:

<br/><br/>
<img
src="../../../img/sentry_init.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

For your account, the free `Developer` account should be sufficient, as defined in [Sentry's pricing structure](https://sentry.io/pricing/).

##### Select Django as an App Type

DANDI Archive API is built as a Django app -- so proceed to select `Django` on the following screen:

<br/><br/>
<img
src="../../../img/sentry_django.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

##### Capture Sentry DSN value

You'll be provided with a screen displaying how to initialize and install Sentry into your Django app. For now, just capture the DSN value.
This value will be used later as an environment variable while deploying your API via Terraform.

<br/><br/>
<img
src="../../../img/sentry_sdk_dsn.jpg"
alt="retrieve"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

## datalad

We will add docs in the future (https://github.com/dandi/dandi-docs/issues/132).

## git-annex

We will add docs in the future (https://github.com/dandi/dandi-docs/issues/132).
