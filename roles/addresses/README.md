jugasit.gcp.addresses
=====================

This role creates and manages GCP addresses.

Role Variables
--------------

This role supports the [Common Role Variables](https://gitlab.com/jugasit/ansible/gcp/blob/develop/README.md#common-role-variables).

The main data structure for this role is the list of `gcp_addresses`. Each `address` requires the following fields:

- `name`: The name of the address.

Example Playbooks
-----------------

Create a basic address that uses.

```yaml
- hosts: localhost
  vars:
    gcp_addresses:
      - name: my-address
  roles:
    - role: jugasit.gcp.addresses
```
