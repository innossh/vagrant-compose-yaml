begin
  require 'vagrant'
rescue LoadError
  raise 'The Vagrant Compose Yaml plugin must be run within Vagrant.'
end

module VagrantPlugins
  module ComposeYaml
    class Plugin < Vagrant.plugin('2')
      name 'compose-yaml'
      description <<-DESC
      The `compose-yaml` command sets up your working directory to be a
      Vagrant-managed multi-machine environment by YAML.
      DESC

      command('compose-yaml') do
        require_relative 'command'
        Command
      end
    end
  end
end
