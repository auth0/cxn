![](http://cdn.auth0.com/img/banner-cxn.png)

This is an opensource cookbook to configure the nodes of cXn.

What you need to know:

-  The architecture is *nginx (ssl/app)* -> *varnish (cache)* -> *s3 (storage)*.
-  The project uses [Chef](https://www.chef.io) to configure the nodes of the CDN.
-  The nodes use Ubuntu and you are supposed to provision them manually (for now).
-  The Route53 configuration is done manually (for now).

## Setup

The configuration of the CDN fits in a JSON format as follows and is stored in "environments/":

```json
{
  "nodes": {
    "cdn-example-node-1": "54.54.54.54",
    "cdn-example-node-2": "54.54.54.54"
  },
  "purgers": {
    "my-ci-server-1":   "54.54.54.54",
    "some-other-thing": "54.54.54.54"
  },
  "newrelic": "my-new-relic-token",
  "varnish": {
    "storage_size": "4g"
  },
  "domains": [
    {
      "id":            "global",
      "domain":        "cdn.mycompany.com",
      "bucket":        "my-s3-bucket",
      "bucket_region": "us-east-1",
      "ssl":           true
    }
  ]
}
```

-  **nodes** (required): is a hash of the nodes on the CDN. The key is the hostname and the value is the public IP Address.
-  **purgers** (required): is a hash of nodes allowed to purge the CDN from outside. The key of the hash is not used anywhere and the value is the IP Address.
-  **newrelic** (optional): is the [newrelic](http://newrelic.com) token. If set the Newrelic agent will be installed and configured on every machine.
-  **domains** (required): is a list of the domains handled by the CDN. Each domain has the following attributes:
    -  **id**: friendly name for the domain
    -  **domain**: the domain for the CDN.
    -  **bucket**: the S3 backend of the CDN.
    -  **bucket_region**: the region on the S3 bucket.
    -  **ssl**: enable/disable https.

## Testing

You can use vagrant to test things locally:

```
vagrant up
```

In this case the configuration payload is defined inside the Vagrant.pp file.

## Provision

Create nodes in different geographical regions of AWS or any other service provider with Ubuntu.

Prepare the node with `./prepare-node` before deploying.

## Deploy

Make sure you have [Chef-DK](https://downloads.getchef.com/chef-dk/) installed.

Install the cookbooks locally:

~~~
berks install
~~~

Create a `environments/production.json` file and run the `./deploy` command.

You will need to have ssh access to the nodes of the CDN you are going to configure.

## Purging the CDN

Purging of the CDN works by doing a DELETE request:

```
curl -XDELETE https://mycdn.com/some/assets
# these urls will get purged in this case:
#  https://mycdn.com/some/assets/foo.js
#  https://mycdn.com/some/assets/bar.js
#  https://mycdn.com/some/assets/bar/baz.js
```

It will automatically purge on the node being hit and it will propagate back to every other node in the CDN.

This purge request is not authenticated but every node keeps a list of allowed nodes (purgers + nodes).

## DNS

You can start with Route53 Latency based DNS. This reduce latency for your users by serving their requests from the Amazon EC2 region for which network latency is lowest.

AWS might not have enough regions for you. Auth0 CDN for instance use a combination of **Geolocation Routing** + **Lantency Based**.

The first level of DNS (cdn.auth0.com) uses GeoLocation and it has a default CNAME pointing to a Latency based record (cdn-global.auth0.com).

This allow us to point specific countries to other (non-AWS) VPS providers.

## TODO

We plan to build an opensource [Terraform](https://www.terraform.io/) project to automatically create the EC2 instances and the Route53 configuration.

## Issue Reporting

If you have found a bug or if you have a feature request, please report them at this repository issues section. Please do not report security vulnerabilities on the public GitHub issue tracker. The [Responsible Disclosure Program](https://auth0.com/whitehat) details the procedure for disclosing security issues.

## Author

[Auth0](https://auth0.com/)

## License

This project is licensed under the MIT license. See the [LICENSE](LICENSE) file for more info.
