# jugasit.gcp.remove_instances

Use this playbook for a simplified way of removing instances in Google Cloud Platform.

## Requirements

See the [Common Role Requirements](https://gitlab.com/jugasit/ansible/gcp/-/blob/main/README.md#common-role-requirements).

## Usage

```yaml
- import_playbook: jugasit.gcp.remove_instances
```

### Available tags

Control which resources to remove or not remove by including or skipping the following tags:

- `gcp` - Remove all resources listed below
- `addresses` - Remove IP addresses
- `instances` - Remove instances

## Configuration

Place the variables for configuring the playbook either using the `var` keyword directly under `import_playbook`, or
put the variables in either groups or hosts inside the inventory.

To simplify definition of instances, this playbook uses the variable `gcp_instances_simplified`. Example:

```yaml
- import_playbook: jugasit.gcp.remove_instances
  vars:
    gcp_project: my-project
    gco_region: europe-north1
    gcp_zone: europe-north1-a
    gcp_service_account_file: /path/to/credentials.json
    gcp_instances_simplified:
      - name: instance1
        machine_type: n2-standard-2
        disk: 50
```
