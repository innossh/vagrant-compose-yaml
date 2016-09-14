require 'vagrant'
require 'yaml'

module VagrantPlugins
  module ComposeYaml
    class Command < Vagrant.plugin('2', :command)
      def execute
        options = {
            file: 'vagrant-compose.yml',
            force: false,
            output: 'Vagrantfile',
        }

        opts = OptionParser.new do |o|
          o.banner = 'Usage: vagrant compose-yaml [options]'
          o.separator ''
          o.separator 'Options:'
          o.separator ''

          o.on('-f', '--file FILE', String, 'Specify an alternate compose file (default: vagrant-compose.yml)') do |file|
            options[:file] = file
          end
          o.on('--force', 'Overwrite existing Vagrantfile') do |force|
            options[:force] = force
          end
          o.on('--output FILE', String, "Specify an alternate Vagrantfile ('-' for stdout)") do |output|
            options[:output] = output
          end
        end

        # Parse the options
        argv = parse_options(opts)
        return if !argv

        save_path = nil
        if options[:output] != '-'
          save_path = Pathname.new(options[:output]).expand_path(@env.cwd)
          save_path.delete if save_path.exist? && options[:force]
          raise Vagrant::Errors::VagrantfileExistsError if save_path.exist?
        end

        template = 'templates/Vagrantfile'
        template_path = ::VagrantPlugins::ComposeYaml.source_root.join(template)
        vagrantfile_data = yaml2vagrantdata(Pathname.new(options[:file]).expand_path(@env.cwd))
        contents = Vagrant::Util::TemplateRenderer.render(template_path, vagrantfile_data)

        if save_path
          begin
            save_path.open('w+') do |f|
              f.write(contents)
            end
          rescue Errno::EACCES
            raise Vagrant::Errors::VagrantfileWriteError
          end

          @env.ui.info(I18n.t('vagrant.commands.init.success'), prefix: false)
        else
          @env.ui.info(contents, prefix: false)
        end

        0
      end

      def yaml2vagrantdata(yaml_path)
        yaml = YAML.load_file(yaml_path)
        yaml['services'].each do |name, service|
          if service['ports'] != nil
            service['forwarded_port'] = Array.new
            service['ports'].each do |port|
              host, guest = port.split(':')
              service['forwarded_port'].push({'host' => host, 'guest' => guest})
            end
          end
          if service['volumes'] != nil
            service['synced_folder'] = Array.new
            service['volumes'].each do |volume|
              host, guest = volume.split(':')
              service['synced_folder'].push({'host' => host, 'guest' => guest})
            end
          end
        end
        yaml
      end
    end
  end
end
