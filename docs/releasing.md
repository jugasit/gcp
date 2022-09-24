# Releasing the collection

- Go to [Repository > Tags on GitLab](https://gitlab.com/jugasit/ansible/gcp/-/tags).
- Click on **New tag**.
- Fill out **Tag name** with the new version. For example `1.2.3`.
- Set **Create from** to `main`.
- Fill out **Message** with `Version 1.2.3`.
- Fill out **Release notes** with notable changes. For example:

  ```markdown
  # Features
  - Added new role `xxx` to create XXX in GCP.

  # Bug fixes
  - Fixed spelling error in Readme.
  ```

- Click on **Create tag**.
