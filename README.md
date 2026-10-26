# artsy-hokusai-templates

Templates for Hokusai-backed Projects

## How to use this repository

[Jinja template](https://jinja.palletsprojects.com/) files for different application types should be managed in subdirectories within this repo.

Run `hokusai setup` with the `--template-remote git@github.com:artsy/artsy-hokusai-templates.git --template-dir { target-directory }` option to target a directory of templates in this repository.  You can even specify a branch: `--template-remote git@github.com:artsy/artsy-hokusai-templates.git#my-sick-branch --template-dir { target-directory }`

Available templates: `default`, `nodejs` and `rails-puma`.

### tl;dr

Bootstrap a Rails/Puma project:

```shell
hokusai setup --template-remote git@github.com:artsy/artsy-hokusai-templates.git --template-dir rails-puma [--var horizon_project_id=99]
```

## Template directory structure

The `default` directory contains a basic configuration.  Required files for a template directory are:

- Dockerfile.j2
- .dockerignore.j2
- hokusai/build.yml.j2
- hokusai/development.yml.j2
- hokusai/test.yml.j2
- hokusai/staging.yml.j2
- hokusai/production.yml.j2

To create a new target-directory for a new application type, let's say Scala, run:

```shell
cp -R default scala
```

Then edit these template files for a Scala bootstrap configuration.

Any additional `.j2` template files in the target directory and its child directories will be rendered with the provided template variables, and any other regular files will also be copied with the paths relative to the root of the project when running `hokusai setup`.  Note the `.circleci/config.yml.j2` file within the `default` configuration directory.

`hokusai setup` copies these files without their mode, so a script loses its executable bit. Run scripts through `sh` (e.g. `ENTRYPOINT ["dumb-init", "sh", "./scripts/load_secrets_and_run.sh"]`) instead of relying on the bit.

### Template variables

All templates are rendered with `project_name` and `project_repo` template variables.  You can reference them like so: `{{ project_name }}`.

`hokusai setup` also supports passing in template variables with the `--var` option.  `hokusai setup` fails if a template references a variable that was not passed, unless you add `--allow-missing-vars`.

The templates in this repo use `horizon_project_id` in `.circleci/config.yml.j2`. It defaults to `REPLACE_ME` when not passed.

### CircleCI

CircleCI configuration is setup to use the shared [artsy/hokusai](https://github.com/artsy/orbs/tree/main/src/hokusai) orb and CircleCI config version 2.1. See the [hokusai orb documentation](https://github.com/artsy/orbs/tree/main/src/hokusai) for details.
