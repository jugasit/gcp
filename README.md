# Google Compute Platform Ansible Roles

Ansible roles for interacting with the GCP API.

## Installation

You can install the collection from [Ansible Galaxy](https://galaxy.ansible.com/jugasit/gcp) by running `ansible-galaxy collection install jugasit.gcp`.

## Usage

### Roles

After the installation, the roles are available as `jugasit.gcp.<role_name>`.

For example:

```yaml
- name: Create resources in GCP
  hosts: localhost
  connection: local
  roles:
    - jugasit.gcp.addresses
    - jugasit.gcp.networks
    - jugasit.gcp.firewalls
    - jugasit.gcp.instances
```

Please see the [Using Ansible collections documentation](https://docs.ansible.com/ansible/devel/collections_guide/index.html#collections-index) for further details.

### Playbooks

To use the playbooks:

```yaml
- import_playbook: jugasit.gcp.create_instances
```

### Reference

For the full reference of all roles and playbooks available see [our documentation](https://jugasit.gitlab.io/ansible/gcp).

### Common Role Requirements

#### Packages

The roles in this collection uses modules from the `google.cloud` collection which requires the following packages to be installed:

```shell
sudo dnf install python3-requests python3-google-auth
```

#### Authentication

In order to automate infrastructure in Google Cloud, you must create credentials and select the project to use.

1. [Create service account](https://developers.google.com/identity/protocols/oauth2/service-account#creatinganaccount)
2. Save the JSON keys and point to them using `gcp_service_account_file`
3. Use `gcp_project` to specify the GCP project where the resources should be created.

### Common Role Variables

- `gcp_auth_kind`: The kind of credential to use. If the variable is not specified, the value of environment variable `GCP_AUTH_KIND` will be used instead.
- `gcp_service_account_email`: An optional service account email address if machineaccount is selected and the user does not wish to use the default email. If the variable is not specified, the value of environment variable `GCP_SERVICE_ACCOUNT_EMAIL` will be used instead.
- `gcp_service_account_file`: The path of a Service Account JSON file if serviceaccount is selected as type. If the variable is not specified, the value of environment variable `GCP_SERVICE_ACCOUNT_FILE` will be used instead.
- `gcp_scopes`: The specific scopes that you want the actions to use. If the variable is not specified, the value of environment variable `GCP_SCOPES` will be used instead.
- `gcp_project`: ID of the GCP project.
- `gcp_state`: The state of the resources. Default is `present`.
