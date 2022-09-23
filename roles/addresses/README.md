jugasit.gcp.addresses
=====================

This role creates, manages and deletes IP addresses in Google Compute Platform.

Requirements
------------

See the [Common Role Requirements](https://gitlab.com/jugasit/ansible/gcp/-/blob/main/README.md#common-role-requirements).

Role Variables
--------------

This role supports the [Common Role Variables](https://gitlab.com/jugasit/ansible/gcp/-/blob/main/README.md#common-role-variables).

The main data structure for this role is the list of `gcp_addresses`. Each `address` requires the following fields:

- `name`: The name of the address.

In addition the following optional fields are available:

- `address`: The static external IP address represented by this resource. Only IPv4 is supported. An address may only be specified for INTERNAL address types. The IP address must be inside the specified subnetwork, if any.
- `address_type`: The type of address to reserve. Some valid choices include: “INTERNAL”, “EXTERNAL”. Default: “EXTERNAL”.
- `description`: A short description of the network.
- `network_tier`: The networking tier used for configuring this address. If this field is not specified, it is assumed to be PREMIUM. Some valid choices include: “PREMIUM”, “STANDARD”.
- `purpose`: The purpose of this resource, which can be one of the following values:

  - GCE_ENDPOINT for addresses that are used by VM instances, alias IP ranges, internal load balancers, and similar resources.
  - SHARED_LOADBALANCER_VIP for an address that can be used by multiple internal load balancers.
  - VPC_PEERING for addresses that are reserved for VPC peer networks.

  This should only be set when using an Internal address.

  Some valid choices include: “GCE_ENDPOINT”, “VPC_PEERING”, “SHARED_LOADBALANCER_VIP”

- `region`: URL of the region where the regional address resides.

    This field is not applicable to global addresses.

- `subnetwork`: The URL of the subnetwork in which to reserve the address. If an IP address is specified, it must be within the subnetwork’s IP range.

    This field can only be used with INTERNAL type with GCE_ENDPOINT/DNS_RESOLVER purposes.

    This field represents a link to a Subnetwork resource in GCP. It can be specified in two ways. First, you can place a dictionary with key ‘selfLink’ and value of your resource’s selfLink Alternatively, you can add register: name-of-resource to a gcp_compute_subnetwork task and then set this subnetwork field to “{{ name-of-resource }}”

Example Playbook
----------------

Create a basic IPv4 address:

```yaml
- name: Create GCP addresses
  hosts: localhost
  connection: local
  gather_facts: false
  vars:
    gcp_addresses:
      - name: my-address
        description: My address.
        address_type: EXTERNAL
        network_tier: STANDARD
  roles:
    - jugasit.gcp.addresses
```
