[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>](https://mineiros.io/?ref=terraform-google-compute-address)

[![Build Status](https://github.com/mineiros-io/terraform-google-compute-address/workflows/Tests/badge.svg)](https://github.com/mineiros-io/terraform-google-compute-address/actions)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-google-compute-address.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-google-compute-address/releases)
[![Terraform Version](https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform)](https://github.com/hashicorp/terraform/releases)
[![Google Provider Version](https://img.shields.io/badge/google-4-1A73E8.svg?logo=terraform)](https://github.com/terraform-providers/terraform-provider-google/releases)
[![Join Slack](https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack)](https://mineiros.io/slack)

# terraform-google-compute-address

A [Terraform] module for [Google Cloud Platform (GCP)][gcp].

**_This module supports Terraform version 1
and is compatible with the Terraform Google Provider version 4._**

This module is part of our Infrastructure as Code (IaC) framework
that enables our users and customers to easily deploy and manage reusable,
secure, and production-grade cloud infrastructure.


- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Top-level Arguments](#top-level-arguments)
    - [Module Configuration](#module-configuration)
    - [Main Resource Configuration](#main-resource-configuration)
- [Module Outputs](#module-outputs)
- [External Documentation](#external-documentation)
  - [Google Documentation](#google-documentation)
  - [Terraform Google Provider Documentation](#terraform-google-provider-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

This module implements the following terraform resources:

- `google_compute_address`

## Getting Started

Most basic usage just setting required arguments:

```hcl
module "terraform-google-compute-address" {
    source = "github.com/mineiros-io/terraform-google-compute-address.git?ref=v0.1.0"

    name = "ipv4-address"
}
```

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Top-level Arguments

#### Module Configuration

- [**`module_enabled`**](#var-module_enabled): *(Optional `bool`)*<a name="var-module_enabled"></a>

  Specifies whether resources in the module will be created.

  Default is `true`.

- [**`module_depends_on`**](#var-module_depends_on): *(Optional `list(dependency)`)*<a name="var-module_depends_on"></a>

  A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.

  Example:

  ```hcl
  module_depends_on = [
    google_network.network
  ]
  ```

#### Main Resource Configuration

- [**`name`**](#var-name): *(**Required** `string`)*<a name="var-name"></a>

  Name of the resource. The name must be `1-63` characters long, and comply with RFC1035. Specifically, the name must be 1-63 characters long and match the regular expression `[a-z]([-a-z0-9]*[a-z0-9])?` which means the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash.

- [**`number_of_addresses`**](#var-number_of_addresses): *(Optional `number`)*<a name="var-number_of_addresses"></a>

  How many resources you want to create.

  Default is `1`.

- [**`address`**](#var-address): *(Optional `string`)*<a name="var-address"></a>

  The static external IP address represented by this resource. Only IPv4 is supported. An address may only be specified for `INTERNAL` address types. The IP address must be inside the specified subnetwork, if any.

- [**`address_type`**](#var-address_type): *(Optional `string`)*<a name="var-address_type"></a>

  The type of address to reserve. Possible values are `INTERNAL` and `EXTERNAL`.

  Default is `"EXTERNAL"`.

- [**`description`**](#var-description): *(Optional `string`)*<a name="var-description"></a>

  An optional description of this resource.

- [**`purpose`**](#var-purpose): *(Optional `string`)*<a name="var-purpose"></a>

  The purpose of this resource, which can be one of the following values: `GCE_ENDPOINT`, `SHARED_LOADBALANCER_VIP`, `VPC_PEERING`, `IPSEC_INTERCONNECT`.

- [**`network_tier`**](#var-network_tier): *(Optional `string`)*<a name="var-network_tier"></a>

  The networking tier used for configuring this address. If this field is not specified, it is assumed to be `PREMIUM`. Possible values are `PREMIUM` and `STANDARD`.

- [**`subnetwork`**](#var-subnetwork): *(Optional `string`)*<a name="var-subnetwork"></a>

  The URL of the subnetwork in which to reserve the address. If an IP address is specified, it must be within the subnetwork's IP range. This field can only be used with `INTERNAL` type with `GCE_ENDPOINT/DNS_RESOLVER` purposes.

- [**`network`**](#var-network): *(Optional `string`)*<a name="var-network"></a>

  The URL of the network in which to reserve the address. This field can only be used with `INTERNAL` type with the `VPC_PEERING` and `IPSEC_INTERCONNECT` purposes.

- [**`prefix_length`**](#var-prefix_length): *(Optional `string`)*<a name="var-prefix_length"></a>

  The prefix length if the resource represents an IP range.

- [**`region`**](#var-region): *(Optional `string`)*<a name="var-region"></a>

  The Region in which the created address should reside. If it is not provided, the provider region is used.

- [**`project`**](#var-project): *(Optional `string`)*<a name="var-project"></a>

  The ID of the project in which the resource belongs. If it is not provided, the provider project is used.

## Module Outputs

The following attributes are exported in the outputs of the module:

- **`module_enabled`**

  Whether this module is enabled.

- **`address`**

  All compute address attributes.

## External Documentation

### Google Documentation

- Reserve static internal ip address: https://cloud.google.com/compute/docs/ip-addresses/reserve-static-internal-ip-address
- Reserve static external ip address: https://cloud.google.com/compute/docs/ip-addresses/reserve-static-external-ip-address

### Terraform Google Provider Documentation

- https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)].

Given a version number `MAJOR.MINOR.PATCH`, we increment the:

1. `MAJOR` version when we make incompatible changes,
2. `MINOR` version when we add functionality in a backwards compatible manner, and
3. `PATCH` version when we make backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## About Mineiros

[Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
that solves development, automation and security challenges in cloud infrastructure.

Our vision is to massively reduce time and overhead for teams to manage and
deploy production-grade and secure cloud infrastructure.

We offer commercial support for all of our modules and encourage you to reach out
if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
[Community Slack channel][slack].

## Reporting Issues

We use GitHub [Issues] to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].

## Makefile Targets

This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.

## License

[![license][badge-license]][apache20]
      
This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]


<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-google-compute-address
[hello@mineiros.io]: mailto:hello@mineiros.io
[badge-build]: https://github.com/mineiros-io/terraform-google-compute-address/workflows/Tests/badge.svg
[badge-semver]: https://img.shields.io/github/v/tag/mineiros-io/terraform-google-compute-address.svg?label=latest&sort=semver
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack
[build-status]: https://github.com/mineiros-io/terraform-google-compute-address/actions
[releases-github]: https://github.com/mineiros-io/terraform-google-compute-address/releases
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[badge-tf-gcp]: https://img.shields.io/badge/google-3.x-1A73E8.svg?logo=terraform
[releases-google-provider]: https://github.com/terraform-providers/terraform-provider-google/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://mineiros.io/slack
[terraform]: https://www.terraform.io
[gcp]: https://cloud.google.com/
[semantic versioning (semver)]: https://semver.org/
[variables.tf]: https://github.com/mineiros-io/terraform-google-compute-address/blob/main/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-google-compute-address/blob/main/examples
[issues]: https://github.com/mineiros-io/terraform-google-compute-address/issues
[license]: https://github.com/mineiros-io/terraform-google-compute-address/blob/main/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-google-compute-address/blob/main/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-google-compute-address/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-google-compute-address/blob/main/CONTRIBUTING.md
