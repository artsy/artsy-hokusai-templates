# artsy-hokusai-templates

Templates for Hokusai-backed Projects

[Jinja template](http://jinja.pocoo.org/docs/2.10/) files for different application types should be managed in subdirectories within this repo.

Run `hokusai setup` with the `--template-remote git@github.com:artsy/artsy-hokusai-templates.git` option to target this repository.  You can even specify a branch: `--template-remote git@github.com:artsy/artsy-hokusai-templates.git#my-sick-branch`

Application developers can set up a project by specifying which target directory they want to use for templates by running `hokusai setup` with the `--template-dir` option.

The `default` directory contains a basic configuration.  Required files for a template directory are:

- Dockerfile.j2
- .dockerignore.j2
- hokusai/build.yml.j2
- hokusai/development.yml.j2
- hokusai/test.yml.j2
- hokusai/staging.yml.j2
- hokusai/production.yml.j2

All templates are rendered with `project_name` and `project_repo` template variables.  You can reference them like so: `{{ project_name }}`.

`hokusai setup` also supports passing in template variables with the `--var` option.  Users will get a warning if trying to render a template with a defined but unspecified variable.

Any additional `.j2` template files in the target directory and its child directories will be rendered with the provided template variables, and any other regular files will also be copied with the paths relative to the root of the project when running `hokusai setup`.  Note the `.circleci/config.yml` file within the `default` configuration directory.

So to summarize: setup up a default application configuration with `hokusai setup --template-remote git@github.com:artsy/artsy-hokusai-templates.git --template-dir default`
