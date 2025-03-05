## Configuring Terraform

[First, make sure you have set up your Terraform Cloud account and linked the account to the GitHub repository](./initialize-vendors.md#terraform-cloud)

To double-check whether your GitHub repository is linked, proceed to the `Version Control` tab.

The `Version Control` Repository value should point to the repository, and the `Terraform Working Directory` should point to `terraform` 

<br/><br/>
<img
src="../../../img/terraform_config.jpg"
alt="terraform_config"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

As described in the [Understanding the DANDI Infrastructure](#understanding-the-dandi-infrastructure) section, the [dandi-infrastructure](https://github.com/dandi/dandi-infrastructure) 
repository includes many components that may not be needed for your use case.  You will need to define the infrastructure components in stepwise fashion, starting with the `api.tf` and `sponsored_bucket.tf`.

## Applying Terraform

There are two ways in which you can invoke `terraform plan` and `terraform apply` upon your infrastructure.

### Automatic Run Triggering

This is set to occur by default when you connect a GitHub repository to Terraform Cloud. After pushing code to your repository,
Terraform will run `terraform plan`, generating a summary of what will happen if you were to run `terraform apply`. 

**Note: `terraform apply` will not be run automatically (this is good!), so be sure to review and check prior to applying.

To view, go to the `Runs` tab -- you will see that the Terraform run populates the GitHub code action above

<br/><br/>
<img
src="../../../img/terraform_auto.jpg"
alt="terraform_auto"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

### Trigger Run from UI manually

If you'd like more control over Terraform, you can also default to run manually.

<br/><br/>
<img
src="../../../img/terraform_manual.jpg"
alt="terraform_manual"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

## Understanding the DANDI Infrastructure

### Resonant

In the [api.tf definition](https://github.com/dandi/dandi-infrastructure/blob/master/terraform/api.tf), there is reference
to a `source` keyword, where a Terraform module called [Resonant](https://github.com/kitware-resonant/terraform-heroku-resonant) is defined.

In the Resonant submodule, AWS and Heroku resources are defined that facilitate base resources for compute and networking to work with DANDI Archive.
Within the DANDI Infrastructure downstream, Resonant is used by declaring values that the Terraform module expects. **Resources declared by Resonant cannot be overwritten**

#### Sponsored Bucket

**This is DANDI Archive specific** in which the code in `main.tf` and the presence of downstream-related files should be commented out for any clones.

A `sponsored bucket` is also declared in the `main.tf`, with downstream, related files called `sponsored_iam.tf` and `sponsored_bucket.tf`.

## Domain Management

**DANDI Infrastructure assumes that you 1. own a domain, and 2. have purchased that domain (or have that domain managed) via AWS Route 53**

DANDI Infrastructure connects domains from three different vendors:

- **Netlify**: Manages load balancer IPs and custom domains for the UI.
- **AWS Route 53**: Manages CNAME records for SSL certificates and links Heroku API URLs to domains.
- **Heroku**: Provides domains for API services, which are aliased via AWS Route 53.

### Netlify

Although Netlify prescribes mapping of Netlify-issued DNS records directly, DANDI Infrastructure relies on mapping Netlify's Load Balancer IP to the respective A Name Record in AWS Route 53, 
as prescribed in [Netlify's docs](https://docs.netlify.com/domains-https/custom-domains/configure-external-dns/#configure-an-apex-domain)

```
resource "aws_route53_record" "gui" {
  zone_id = aws_route53_zone.dandi.zone_id
  name    = "" # apex
  type    = "A"
  ttl     = "300"
  records = ["75.2.60.5"] # Netlify's load balancer, which will proxy to our app
}
```

Note the code snippet above is from the DANDI Infrastructure [domain.tf](https://github.com/dandi/dandi-infrastructure/blob/master/terraform/domain.tf#L13).

### AWS Route 53 and ACM

A manual step is necessary to set up an SSL Certificate for your DNS records throughout your DANDI clone. 

Proceed to AWS `Certificate Manager`. Begin by requesting a certificate -- **Note: Ensure you are in the same region as the default you have provided in your Terraform `main.tf` template.

<br/><br/>
<img
src="../../../img/aws_acm_dashboard.jpg"
alt="aws_acm_dashboard"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

Next, request a `Public Certificate`

<br/><br/>
<img
src="../../../img/public_cert.jpg"
alt="public_cert"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

When setting up the certificate, provide a value of `*.<your_domain_name>` -- the goal being that the `*` will serve as a wildcard for both your API and UI DNS records.

<br/><br/>
<img
src="../../../img/valid_domain_acm.jpg"
alt="valid_domain_acm"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

Lastly, validate your certificate via DNS Records. This can be done by using the CNAME values 
expressed by the certificate and linking them as records in your DNS Hosted Zone.

### Heroku Dyno Sizes

`dandi-infrastructure` defines "dyno" (a.k.a process) sizes for each service being run. For specific reference,
[see here in api.tf](https://github.com/dandi/dandi-infrastructure/blob/master/terraform/api.tf#L14-L18).

While your DANDI Archive clone may differ in traffic and activity, the defaults set in `dandi-infrastructure` rarely
exceed 75% usage.

Keep in mind the different [pricing structures](https://www.heroku.com/pricing) that come with choosing different Heroku dyno sizes

### Heroku Add-Ons

In addition to the Heroku 'dynos' that are added for compute, multiple Heroku 'add-ons' are included

- [CloudAMQP](https://elements.heroku.com/addons/cloudamqp) -- **Use Case**: Message Broker
- [Postgres](https://elements.heroku.com/addons/heroku-postgresql) -- **Use Case**: Database
- [Papertrail](https://elements.heroku.com/addons/papertrail) -- **Use Case**: Log Management

### Heroku API Domain

Heroku will provision an API endpoint for your DANDI Archive. In order to properly map and configure that domain, first proceed to the 
`Settings` tab in Heroku.

<br/><br/>
<img
src="../../../img/heroku_settings.jpg"
alt="heroku_settings"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

Scroll down and find configuration options for SSL and Domains. Heroku will give you a random DNS target for 
the API (in the case of the screenshot below `sleepy-jellyfish-0e1p913yo2bgizl1808pss2p.herokudns.com`)

<br/><br/>
<img
src="../../../img/heroku_domain_config.jpg"
alt="heroku_domain_config"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

Proceed to AWS Route 53. Create a corresponding CNAME that maps to the DNS target provided by Heroku.

<br/><br/>
<img
src="../../../img/heroku_cname.jpg"
alt="heroku_cname"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

As long as the CNAME is covered by a valid SSL certificate, should be fully set up now.

## AWS Buckets

While [Resonant](https://github.com/kitware-resonant/terraform-heroku-resonant) does declare S3-based resources, configuration is still needed within DANDI Infrastructure.
Find your AWS Account ID. This value will be referenced in the `main.tf` Terraform template.

<br/><br/>
<img
src="../../../img/aws_account.jpg"
alt="aws_account"
style="width: 60%; height: auto; display: block; margin-left: auto;  margin-right: auto;"/>
<br/><br/>

Populate the value in the [appropriate account ID reference](https://github.com/dandi/dandi-infrastructure/blob/master/terraform/main.tf#L14) in the `main.tf` template.

### Staging vs. Production

For staging, you can modify and apply the [staging_bucket.tf](https://github.com/dandi/dandi-infrastructure/blob/master/terraform/staging_bucket.tf) 
and [staging_pipeline.tf](https://github.com/dandi/dandi-infrastructure/blob/master/terraform/staging_pipeline.tf).

Setting up staging will require unique AWS Route 53 Domains, as well a different Heroku app with different compute.

**Note -- ensure you review your `web/netlify.toml` file in DANDI Archive -- this will define different environment variables that correspond with staging vs. production**

### Email Setup

We will add docs in the future (https://github.com/dandi/dandi-docs/issues/177).
