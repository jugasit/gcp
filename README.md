# Google Compute Platform Ansible Roles

Ansible roles for interacting with the GCP API.

## Documentation

A list of all roles and their documentation can be found in the directory of each role.

## Installation

You can install the collection from [Ansible Galaxy](https://galaxy.ansible.com/jugasit/gcp) by running `ansible-galaxy collection install jugasit.gcp`.

After the installation, the roles are available as `jugasit.gcp.<module_name>`. Please see the [Using Ansible collections documentation](https://docs.ansible.com/ansible/devel/user_guide/collections_using.html) for further details.

### Common Role Variables

- `gcp_auth_kind`: The kind of credential to use. If the variable is not specified, the value of environment variable `GCP_AUTH_KIND` will be used instead.
- `gcp_service_account_email`: An optional service account email address if machineaccount is selected and the user does not wish to use the default email. If the variable is not specified, the value of environment variable `GCP_SERVICE_ACCOUNT_EMAIL` will be used instead.
- `gcp_service_account_file`: The path of a Service Account JSON file if serviceaccount is selected as type. If the variable is not specified, the value of environment variable `GCP_SERVICE_ACCOUNT_FILE` will be used instead.
- `gcp_scopes`: The specific scopes that you want the actions to use. If the variable is not specified, the value of environment variable `GCP_SCOPES` will be used instead.
- `gcp_project`: ID of the GCP project.
- `gcp_state`: The state of the resources. Default is `present`.
