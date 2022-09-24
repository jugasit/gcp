jugasit.gcp.firewalls
=====================

This role creates, manages and deletes firewalls in Google Compute Platform.

Requirements
------------

See the [Common Role Requirements](https://gitlab.com/jugasit/ansible/gcp/-/blob/main/README.md#common-role-requirements).

Role Variables
--------------

This role supports the [Common Role Variables](https://gitlab.com/jugasit/ansible/gcp/-/blob/main/README.md#common-role-variables).

The main data structure for this role is the list of `gcp_firewalls`. Each `firewall` requires the following fields:

- `name`: The name of the firewall.

In addition the following optional fields are available:

- `allowed`: The list of *ALLOW* rules specified by this firewall. Each rule specifies a protocol and port-range tuple that describes a permitted connection.
- `denied`: The list of *DENY* rules specified by this firewall. Each rule specifies a protocol and port-range tuple that describes a denied connection.
- `description`: An optional description of this resource. Provide this property when you create the resource.
- `destination_ranges`: If destination ranges are specified, the firewall will apply only to traffic that has destination IP address in these ranges. These ranges must be expressed in CIDR format. Only IPv4 is supported.
- `direction`: Direction of traffic to which this firewall applies; default is `INGRESS`.

    Note: For *INGRESS* traffic, it is **NOT** supported to specify `destination_ranges`;
    For *EGRESS* traffic, it is **NOT** supported to specify `source_ranges` **OR** `source_tags`.

    Choices:

    - `INGRESS`
    - `EGRESS`

- `disabled`: Denotes whether the firewall rule is disabled, i.e not applied to the network it is associated with.
    When set to `true`, the firewall rule is not enforced and the network behaves as if it did not exist.
    If this is unspecified, the firewall rule will be enabled.

    Choices:

    - `no`
    - `yes`

- `log_config`: This field denotes the logging options for a particular firewall rule.
    If logging is enabled, logs will be exported to Cloud Logging.

- `network`: URL of the network resource for this firewall rule.
    If not specified when creating a firewall rule, the default network is used: `global/networks/default`.
    If you choose to specify this property, you can specify the network as a full or partial URL.
    For example, the following are all valid URLs:

      - `https://www.googleapis.com/compute/v1/projects/myproject/global/`
      - `networks/my-network`
      - `projects/myproject/global/networks/my-network global/networks/default`

    This field represents a link to a Network resource in GCP. It can be specified in two ways.
    First, you can place a dictionary with key `selfLink` and value of your resource’s `selfLink`.
    Alternatively, you can add `register: name-of-resource` to a `gcp_compute_network` task
    and then set this network field to `{{ name-of-resource }}`

    Default: `{"selfLink": "global/networks/default"}`

- `priority`: Priority for this rule. This is an integer between 0 and 65535, both inclusive.
    When not specified, the value assumed is `1000`. Relative priorities determine precedence of conflicting rules.
    Lower value of priority implies higher precedence
    (eg, a rule with priority `0` has higher precedence than a rule with priority `1`).
    DENY rules take precedence over *ALLOW* rules having equal priority.

    Default: `1000`

- `source_ranges`: If source ranges are specified, the firewall will apply only to traffic that has source IP address
    in these ranges. These ranges must be expressed in CIDR format.
    One or both of `source_ranges` and `source_tags` may be set.
    If both properties are set, the firewall will apply to traffic that has source IP address
    within `source_ranges` **OR** the source IP that belongs to a tag listed in the `source_tags` property.
    The connection does not need to match both properties for the firewall to apply. Only IPv4 is supported.

- `source_service_accounts`: If source service accounts are specified,
    the firewall will apply only to traffic originating from an instance with a service account in this list.
    Source service accounts cannot be used to control traffic to an instance’s external IP address because service
    accounts are associated with an instance, not an IP address. `source_ranges` can be set at the same time
    as `source_service_accounts`. If both are set, the firewall will apply to traffic that has source IP address
    within `source_ranges` OR the source IP belongs to an instance with service account listed in
    `sourceServiceAccount`. The connection does not need to match both properties for the firewall to apply.
    `sourceServiceAccounts` cannot be used at the same time as `source_tags` or `targetTags`.

- `source_tags`: If source tags are specified, the firewall will apply only to traffic with source IP that belongs to a
    tag listed in source tags. Source tags cannot be used to control traffic to an instance’s external IP address.
    Because tags are associated with an instance, not an IP address.
    One or both of `source_ranges` and `source_tags` may be set.
    If both properties are set, the firewall will apply to traffic that has source IP address within `source_ranges`
    **OR** the source IP that belongs to a tag listed in the `source_tags` property.
    The connection does not need to match both properties for the firewall to apply.

- `target_service_accounts`: A list of service accounts indicating sets of instances located in the network that may
    make network connections as specified in `allowed`.
    `target_service_accounts` cannot be used at the same time as `target_tags` or `source_tags`.
    If neither `target_service_accounts` nor `target_tags` are specified, the firewall rule applies to all instances on
    the specified network.

- `target_tags`: A list of instance tags indicating sets of instances located in the network that may make network
    connections as specified in `allowed`.
    If no `target_tags` are specified, the firewall rule applies to all instances on the specified network.

Example Playbook
----------------

Create a firewall allowing HTTP and HTTPS from `192.168.0.0/24`:

```yaml
- name: Create GCP firewalls
  hosts: localhost
  connection: local
  gather_facts: false
  vars:
    gcp_firewalls:
      - name: my-firewall
        description: My firewall.
        network:
          selfLink: global/networks/my-network
        source_ranges:
          - 192.168.0.0/24
        allowed:
          - ip_protocol: tcp
            ports:
              - 80
              - 443
  roles:
    - jugasit.gcp.firewalls
```
