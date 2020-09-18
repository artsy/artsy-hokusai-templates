# artsy-hokusai-templates

Templates for Hokusai-backed Projects

## How to use this repository

[Jinja template](http://jinja.pocoo.org/docs/2.10/) files for different application types should be managed in subdirectories within this repo.

Run `hokusai setup` with the `--template-remote git@github.com:artsy/artsy-hokusai-templates.git --template-dir { target-directory }` option to target a directory of templates in this repository.  You can even specify a branch: `--template-remote git@github.com:artsy/artsy-hokusai-templates.git#my-sick-branch --template-dir { target-directory }`

Application developers can set up a project by specifying which target directory they want to use for templates by running `hokusai setup` with the `--template-dir` option.

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

Any additional `.j2` template files in the target directory and its child directories will be rendered with the provided template variables, and any other regular files will also be copied with the paths relative to the root of the project when running `hokusai setup`.  Note the `.circleci/config.yml` file within the `default` configuration directory.

### Template variables

All templates are rendered with `project_name` and `project_repo` template variables.  You can reference them like so: `{{ project_name }}`.

`hokusai setup` also supports passing in template variables with the `--var` option.  Users will get a warning if trying to render a template with a defined but unspecified variable.

### CircleCI

CircleCI configuration is setup to use the shared [artsy/hokusai](https://github.com/artsy/orbs/tree/master/src/hokusai) orb. Using this requires updating an app's CircleCI settings to use version 2.1. See the [hokusai orb documentation](https://github.com/artsy/orbs/tree/master/src/hokusai) for details.
