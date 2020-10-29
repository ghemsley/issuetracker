require 'optparse'
require 'issuetracker/version'
module Issuetracker
  class CLI
    def initialize
      @options = {}
      OptionParser.new do |opts|
        opts.banner = 'Usage: issuetracker [options]'
        opts.on('-p', '--project PROJECT_PATH', 'Path to the project to display or operate on') do |project_path|
          @options[:project_path] = project_path
        end
        
        opts.on('-v', '--version', 'Display the program version. Overrides all other option behaviors') do
          puts VERSION
          exit
        end
        opts.on('-h', '--help', 'Displays a helpful usage guide') do
          puts opts
          exit
        end
      end.parse!
    end

    attr_reader :options
  end
end
