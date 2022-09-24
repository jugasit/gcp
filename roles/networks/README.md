jugasit.gcp.networks
====================

This role creates, manages and deletes networks in Google Compute Platform.

Requirements
------------

See the [Common Role Requirements](https://gitlab.com/jugasit/ansible/gcp/-/blob/main/README.md#common-role-requirements).

Role Variables
--------------

This role supports the [Common Role Variables](https://gitlab.com/jugasit/ansible/gcp/-/blob/main/README.md#common-role-variables).

The main data structure for this role is the list of `gcp_networks`. Each `network` requires the following fields:

- `name`: The name of the network.

In addition the following optional fields are available:

- `auto_create_subnetworks`: When set to `true`, the network is created in “auto subnet mode” and it will create a
    subnet for each region automatically across the `10.128.0.0/9` address range.

    When set to `false`, the network is created in *custom subnet mode* so the user can explicitly connect
    subnetwork resources.

    Choices:

    - `no`
    - `yes`

    Default: `yes`.

- `description`: An optional description of this resource. The resource must be recreated to modify this field.
- `mtu`: Maximum Transmission Unit in bytes.
    The minimum value for this field is `1460` and the maximum value is `1500` bytes.
- `routing_config`: The network-level routing configuration for this network.
    Used by Cloud Router to determine what type of network-wide routing behavior to enforce.

Example Playbook
----------------

Create a network with global routing:

```yaml
- name: Create GCP networks
  hosts: localhost
  connection: local
  gather_facts: false
  vars:
    gcp_networks:
      - name: my-network
        description: My network.
        mtu: 1500
        routing_config:
          routing_mode: GLOBAL
  roles:
    - jugasit.gcp.networks
```
