header {
  image = "https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg"
  url   = "https://mineiros.io/?ref=terraform-google-compute-address"

  badge "build" {
    image = "https://github.com/mineiros-io/terraform-google-compute-address/workflows/Tests/badge.svg"
    url   = "https://github.com/mineiros-io/terraform-google-compute-address/actions"
    text  = "Build Status"
  }

  badge "semver" {
    image = "https://img.shields.io/github/v/tag/mineiros-io/terraform-google-compute-address.svg?label=latest&sort=semver"
    url   = "https://github.com/mineiros-io/terraform-google-compute-address/releases"
    text  = "GitHub tag (latest SemVer)"
  }

  badge "terraform" {
    image = "https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform"
    url   = "https://github.com/hashicorp/terraform/releases"
    text  = "Terraform Version"
  }

  badge "tf-gcp-provider" {
    image = "https://img.shields.io/badge/google-4-1A73E8.svg?logo=terraform"
    url   = "https://github.com/terraform-providers/terraform-provider-google/releases"
    text  = "Google Provider Version"
  }

  badge "slack" {
    image = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
    url   = "https://mineiros.io/slack"
    text  = "Join Slack"
  }
}

section {
  title   = "terraform-google-compute-address"
  toc     = true
  content = <<-END
    A [Terraform] module for [Google Cloud Platform (GCP)][gcp].

    **_This module supports Terraform version 1
    and is compatible with the Terraform Google Provider version 4._**

    This module is part of our Infrastructure as Code (IaC) framework
    that enables our users and customers to easily deploy and manage reusable,
    secure, and production-grade cloud infrastructure.
  END

  section {
    title   = "Module Features"
    content = <<-END
      This module implements the following terraform resources:

      - `google_compute_address`
    END
  }

  section {
    title   = "Getting Started"
    content = <<-END
      Most basic usage just setting required arguments:

      ```hcl
      module "terraform-google-compute-address" {
          source = "github.com/mineiros-io/terraform-google-compute-address.git?ref=v0.0.2"

          name = "ipv4-address"
      }
      ```
    END
  }

  section {
    title   = "Module Argument Reference"
    content = <<-END
      See [variables.tf] and [examples/] for details and use-cases.
    END

    section {
      title = "Top-level Arguments"

      section {
        title = "Module Configuration"

        variable "module_enabled" {
          type        = bool
          default     = true
          description = <<-END
            Specifies whether resources in the module will be created.
          END
        }

        variable "module_depends_on" {
          type           = list(dependency)
          description    = <<-END
            A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.
          END
          readme_example = <<-END
            module_depends_on = [
              google_network.network
            ]
          END
        }
      }

      section {
        title = "Main Resource Configuration"

        variable "name" {
          required    = true
          type        = string
          description = <<-END
            Name of the resource. The name must be `1-63` characters long, and comply with RFC1035. Specifically, the name must be 1-63 characters long and match the regular expression `[a-z]([-a-z0-9]*[a-z0-9])?` which means the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash.
          END
        }

        variable "number_of_addresses" {
          type        = number
          default     = 1
          description = <<-END
            How many resources you want to create.
          END
        }

        variable "address" {
          type        = string
          description = <<-END
            The static external IP address represented by this resource. Only IPv4 is supported. An address may only be specified for `INTERNAL` address types. The IP address must be inside the specified subnetwork, if any.
          END
        }

        variable "address_type" {
          type        = string
          default     = "EXTERNAL"
          description = <<-END
            The type of address to reserve. Possible values are `INTERNAL` and `EXTERNAL`.
          END
        }

        variable "description" {
          type        = string
          description = <<-END
            An optional description of this resource.
          END
        }

        variable "purpose" {
          type        = string
          description = <<-END
            The purpose of this resource, which can be one of the following values: `GCE_ENDPOINT`, `SHARED_LOADBALANCER_VIP`, `VPC_PEERING`, `IPSEC_INTERCONNECT`.
          END
        }

        variable "network_tier" {
          type        = string
          description = <<-END
            The networking tier used for configuring this address. If this field is not specified, it is assumed to be `PREMIUM`. Possible values are `PREMIUM` and `STANDARD`.
          END
        }

        variable "subnetwork" {
          type        = string
          description = <<-END
            The URL of the subnetwork in which to reserve the address. If an IP address is specified, it must be within the subnetwork's IP range. This field can only be used with `INTERNAL` type with `GCE_ENDPOINT/DNS_RESOLVER` purposes.
          END
        }

        variable "network" {
          type        = string
          description = <<-END
            The URL of the network in which to reserve the address. This field can only be used with `INTERNAL` type with the `VPC_PEERING` and `IPSEC_INTERCONNECT` purposes.
          END
        }

        variable "prefix_length" {
          type        = string
          description = <<-END
            The prefix length if the resource represents an IP range.
          END
        }

        variable "region" {
          type        = string
          description = <<-END
            The Region in which the created address should reside. If it is not provided, the provider region is used.
          END
        }

        variable "project" {
          type        = string
          description = <<-END
            The ID of the project in which the resource belongs. If it is not provided, the provider project is used.
          END
        }
      }
    }
  }

  section {
    title   = "Module Outputs"
    content = <<-END
      The following attributes are exported in the outputs of the module:
    END

    output "module_enabled" {
      type        = bool
      description = <<-END
        Whether this module is enabled.
      END
    }

    output "address" {
      type        = object(address)
      description = <<-END
        All `google_compute_address` attributes.
      END
    }
  }

  section {
    title = "External Documentation"

    section {
      title   = "Google Documentation"
      content = <<-END
        - Reserve static internal ip address: https://cloud.google.com/compute/docs/ip-addresses/reserve-static-internal-ip-address
        - Reserve static external ip address: https://cloud.google.com/compute/docs/ip-addresses/reserve-static-external-ip-address
      END
    }

    section {
      title   = "Terraform Google Provider Documentation"
      content = <<-END
        - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address
      END
    }
  }

  section {
    title   = "Module Versioning"
    content = <<-END
      This Module follows the principles of [Semantic Versioning (SemVer)].

      Given a version number `MAJOR.MINOR.PATCH`, we increment the:

      1. `MAJOR` version when we make incompatible changes,
      2. `MINOR` version when we add functionality in a backwards compatible manner, and
      3. `PATCH` version when we make backwards compatible bug fixes.
    END

    section {
      title   = "Backwards compatibility in `0.0.z` and `0.y.z` version"
      content = <<-END
        - Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
        - Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)
      END
    }
  }

  section {
    title   = "About Mineiros"
    content = <<-END
      [Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
      that solves development, automation and security challenges in cloud infrastructure.

      Our vision is to massively reduce time and overhead for teams to manage and
      deploy production-grade and secure cloud infrastructure.

      We offer commercial support for all of our modules and encourage you to reach out
      if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
      [Community Slack channel][slack].
    END
  }

  section {
    title   = "Reporting Issues"
    content = <<-END
      We use GitHub [Issues] to track community reported issues and missing features.
    END
  }

  section {
    title   = "Contributing"
    content = <<-END
      Contributions are always encouraged and welcome! For the process of accepting changes, we use
      [Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].
    END
  }

  section {
    title   = "Makefile Targets"
    content = <<-END
      This repository comes with a handy [Makefile].
      Run `make help` to see details on each available target.
    END
  }

  section {
    title   = "License"
    content = <<-END
      [![license][badge-license]][apache20]
      
      This module is licensed under the Apache License Version 2.0, January 2004.
      Please see [LICENSE] for full details.

      Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]
    END
  }
}

references {
  ref "homepage" {
    value = "https://mineiros.io/?ref=terraform-google-compute-address"
  }
  ref "hello@mineiros.io" {
    value = "mailto:hello@mineiros.io"
  }
  ref "badge-build" {
    value = "https://github.com/mineiros-io/terraform-google-compute-address/workflows/Tests/badge.svg"
  }
  ref "badge-semver" {
    value = "https://img.shields.io/github/v/tag/mineiros-io/terraform-google-compute-address.svg?label=latest&sort=semver"
  }
  ref "badge-license" {
    value = "https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg"
  }
  ref "badge-terraform" {
    value = "https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform"
  }
  ref "badge-slack" {
    value = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
  }
  ref "build-status" {
    value = "https://github.com/mineiros-io/terraform-google-compute-address/actions"
  }
  ref "releases-github" {
    value = "https://github.com/mineiros-io/terraform-google-compute-address/releases"
  }
  ref "releases-terraform" {
    value = "https://github.com/hashicorp/terraform/releases"
  }
  ref "badge-tf-gcp" {
    value = "https://img.shields.io/badge/google-3.x-1A73E8.svg?logo=terraform"
  }
  ref "releases-google-provider" {
    value = "https://github.com/terraform-providers/terraform-provider-google/releases"
  }
  ref "apache20" {
    value = "https://opensource.org/licenses/Apache-2.0"
  }
  ref "slack" {
    value = "https://mineiros.io/slack"
  }
  ref "terraform" {
    value = "https://www.terraform.io"
  }
  ref "gcp" {
    value = "https://cloud.google.com/"
  }
  ref "semantic versioning (semver)" {
    value = "https://semver.org/"
  }
  ref "variables.tf" {
    value = "https://github.com/mineiros-io/terraform-google-compute-address/blob/main/variables.tf"
  }
  ref "examples/" {
    value = "https://github.com/mineiros-io/terraform-google-compute-address/blob/main/examples"
  }
  ref "issues" {
    value = "https://github.com/mineiros-io/terraform-google-compute-address/issues"
  }
  ref "license" {
    value = "https://github.com/mineiros-io/terraform-google-compute-address/blob/main/LICENSE"
  }
  ref "makefile" {
    value = "https://github.com/mineiros-io/terraform-google-compute-address/blob/main/Makefile"
  }
  ref "pull requests" {
    value = "https://github.com/mineiros-io/terraform-google-compute-address/pulls"
  }
  ref "contribution guidelines" {
    value = "https://github.com/mineiros-io/terraform-google-compute-address/blob/main/CONTRIBUTING.md"
  }
}
