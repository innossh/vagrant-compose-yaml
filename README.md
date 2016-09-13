# Vagrant Compose Yaml

[![Gem Version](https://badge.fury.io/rb/vagrant-compose-yaml.svg)](https://badge.fury.io/rb/vagrant-compose-yaml)

`vagrant-compose-yaml` is a plugin that sets up your working directory to be a Vagrant-managed multi-machine environment by YAML.

## Installation

```
$ vagrant plugin install vagrant-compose-yaml
```

## Usage

Put the YAML file named `vagrant-compose.yml` on your working directory. (e.g. [vagrant-compose.yml](/example/vagrant-compose.yml))
Then run the following commands:

```
$ vagrant compose-yaml
$ vagrant up
```

For more information, you can use the option `--help`.

```
$ vagrant compose-yaml --help
Usage: vagrant compose-yaml [options]

Options:

    -f, --file FILE                  Specify an alternate compose file (default: vagrant-compose.yml)
        --force                      Overwrite existing Vagrantfile
        --output FILE                Specify an alternate Vagrantfile ('-' for stdout)
    -h, --help                       Print this help
```

## Contributing

Fork and create your feature branch. Then commit your changes.
If you want to run this plugin without having to install the gem, you may use bundle exec, like so:

```
$ bundle exec vagrant compose-yaml
```

Finally create new Pull Request.
