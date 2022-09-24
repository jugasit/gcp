jugasit.gcp.instances
=====================

This role creates, manages and deletes instances in Google Compute Platform.

Requirements
------------

See the [Common Role Requirements](https://gitlab.com/jugasit/ansible/gcp/-/blob/main/README.md#common-role-requirements).

Role Variables
--------------

This role supports the [Common Role Variables](https://gitlab.com/jugasit/ansible/gcp/-/blob/main/README.md#common-role-variables).

The main data structure for this role is the list of `gcp_instances`. Each `instance` requires the following fields:

- `name`: The name of the resource, provided by the client when initially creating the resource.
    The resource name must be 1-63 characters long, and comply with RFC1035.
    Specifically, the name must be 1-63 characters long and match the regular expression
    `[a-z]([-a-z0-9]*[a-z0-9])?` which means the first character must be a lowercase letter, and all following
    characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash.

In addition the following optional fields are available:

- `can_ip_forward`: Allows this instance to send and receive packets with non-matching destination or source IPs.
    This is required if you plan to use this instance to forward routes.

    Choices:

    - `no`
    - `yes`

- `deletion_protection`: Whether the resource should be protected against deletion.

    Choices:

    - `no`
    - `yes`

- `disks`: An array of disks that are associated with the instances that are created from this template.
- `guest_accelerators`: List of the type and count of accelerator cards attached to the instance.
- `hostname`: The hostname of the instance to be created.
    The specified hostname must be RFC1035 compliant.
    If hostname is not specified, the default hostname is `[INSTANCE_NAME].c.[PROJECT_ID].internal` when using the
    global DNS, and `[INSTANCE_NAME].[ZONE].c.[PROJECT_ID].internal` when using zonal DNS.

- `labels`: Labels to apply to this instance. A list of key-value pairs.
- `machine_type`: A reference to a machine type which defines VM kind.
- `metadata`: The metadata key/value pairs to assign to instances that are created from this template.
    These pairs can consist of custom metadata or predefined keys.
- `min_cpu_platform`: Specifies a minimum CPU platform for the VM instance. Applicable values are the friendly names of CPU platforms.
- `network_interfaces`: An array of configurations for this interface.
    This specifies how this interface is configured to interact with other network services, such as connecting to the
    internet. Only one network interface is supported per instance.
- `scheduling`: Sets the scheduling options for this instance.
- `service_accounts`: A list of service accounts, with their specified scopes, authorized for this instance.
    Only one service account per VM instance is supported.
- `shielded_instance_config`: Configuration for various parameters related to shielded instances.
- `status`: The status of the instance.

    As a user, use `RUNNING` to keep a machine on and `TERMINATED` to turn a machine off.

    Choices:

    - `PROVISIONING`
    - `STAGING`
    - `RUNNING`
    - `STOPPING`
    - `SUSPENDING`
    - `SUSPENDED`
    - `TERMINATED`

- `tags`: A list of tags to apply to this instance. Tags are used to identify valid sources or targets for network firewalls and are specified by the client during instance creation. The tags can be later modified by the setTags method. Each tag within the list must comply with RFC1035.

- `zone`: A reference to the zone where the machine resides. If not specified then `gcp_zone` will be used.

Example Playbook
----------------

Create a `n2-standard-2` RHEL9 with 50 Gb disk:

```yaml
- name: Create GCP instances
  hosts: localhost
  connection: local
  gather_facts: false
  vars:
    gcp_instances:
      - name: my-instance
        machine_type: n2-standard-2
        labels:
          my_label: something
        disks:
          - auto_delete: true
            boot: true
            type: PERSISTENT
            initialize_params:
              source_image: projects/rhel-cloud/global/images/rhel-9-v20220822
              disk_size_gb: 50
        network_interfaces:
          - network:
              selfLink: global/networks/default
            access_configs:
              - name: External NAT
                nat_ip:
                  selfLink: global/addresses/my-address
                type: ONE_TO_ONE_NAT
        metadata:
          ssh-keys: "{{ lookup('env', 'USER') }}:{{ lookup('file', '~/.ssh/id_rsa.pub') }}"
  roles:
    - jugasit.gcp.instances
```
