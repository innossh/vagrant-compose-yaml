# Vagrant Compose Yaml

`vagrant-compose-yaml` is a plugin that sets up your working directory to be a Vagrant-managed multi-machine environment by YAML.

## Installation

```
$ vagrant plugin install vagrant-compose-yaml
```

## Usage

To set up current directory to be a Vagrant-managed multi-machine environment by `vagrant-compose.yml`, run the following commands:

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
