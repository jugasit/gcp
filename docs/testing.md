# Testing the collection

All changes to this repository are tested using a GitLab CI pipeline.
It is important to add tests when writing new code, to ensure that future changes will not break the code.

It is also a good recommendation to manually test the code during development,
even before you create a commit.

How to write tests, and how to run them, is described below.

## Running tests

### Prerequisites

Start by creating a virtual environment (if you haven't already) and activate it:

```shell
python3 -m venv ./venv
source ./venv/bin/activate
```

Install all necessary packages:

```shell
pip3 install -r requirements.txt
ansible-galaxy collection install -r collections/requirements.yml
```

### Configure access to Google Cloud

In order for Ansible Molecule to manage resources in Google Cloud, you must create credentials and select
the project to use.

1. [Create service account](https://developers.google.com/identity/protocols/oauth2/service-account#creatinganaccount)
2. Save the JSON keys under `tmp/gcp_credentials.json`
3. Set your GCP project as an environment variable by running `export GCP_PROJECT=[project_name]`.

### Run molecule

To run the full chain of tests:

```shell
make test
```

This will:

1. Lint the code, both YAML and Ansible.
1. Create resources in GCP.
1. Verify the resources.
1. Destroy the resources in GCP.

You may also run this steps individually:

```shell
ansible-molecule lint
ansible-molecule create
ansible-molecule verify
ansible-molecule destroy
```

You may specify the scenario to use with `-s SCENARIO|all`.

## Writing tests

During each of the above steps, except for linting, an Ansible playbook is executed.
These playbooks are:

- `molecule/[SCENARIO]/create.yml`
- `molecule/[SCENARIO]/verify.yml`
- `molecule/[SCENARIO]/destroy.yml`

Variables in the default scenario are kept in a separate file:

- `molecule/default/vars.yml`

To add tests just adjust these files accordingly, for example the `vars.yml` to create additional resources,
or the `verify.yml` playbook to make additional verifications.
