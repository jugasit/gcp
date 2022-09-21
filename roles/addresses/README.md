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

- `name`: The name of the activation key.

Dependencies
------------

- `google.cloud`

Example Playbook
----------------

Create a basic IPv4 address:

```yaml

```

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
