# GitHub Actions for Ruby Gems

This Action for [rubygems](https://rubygems.org/) enables arbitrary actions with the `gem` command-line client, including publishing to a registry.

## Usage

An example workflow to build and publish a gem to the default public registry follows:

```yml
on: push
name: Build, Test, and Publish
jobs:
  build:
    name: Build
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Build
      uses: scarhand/actions-ruby@master
      with:
        args: build *.gemspec
    - name: Tag
      uses: actions/bin/filter@master
      with:
        args: tag v*
    - name: Publish
      uses: scarhand/actions-ruby@master
      env:
        RUBYGEMS_AUTH_TOKEN: ${{ secrets.RUBYGEMS_AUTH_TOKEN }}
      with:
        args: push *.gem

```

### Secrets

* `RUBYGEMS_AUTH_TOKEN` - **Optional**. The token to use for authentication with the rubygems repository. Required for `gem push`.

### Environment variables

* `RUBYGEMS_HOST` - **Optional**. To specify a repository to authenticate with. Defaults to `https://rubygems.org` [more info](https://guides.rubygems.org/command-reference/#gem-environment). 

#### Example

To authenticate with, and publish to, a registry other than `https://rubygems.org`:

```yml
on: push
name: Build, Test, and Publish
jobs:
  publish:
    name: Publish
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Publish
      uses: scarhand/actions-ruby@master
      env:
        RUBYGEMS_AUTH_TOKEN: ${{ secrets.RUBYGEMS_AUTH_TOKEN }}
        RUBYGEMS_HOST: https://someOtherRepository.someDomain.net
      with:
        args: push *.gem
```

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).
