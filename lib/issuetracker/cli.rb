require 'optparse'
module Issuetracker
  class CLI
    def initialize
      @options = {}
      OptionParser.new do |options|
        options.banner = 'Usage: issuetracker [options]'
        options.on('-p', '--project PROJECT_NAME', 'Name of the project to operate on') do |project_name|
          @options[:project_name] = project_name
        end
        options.on('-i', '--issue ISSUE_NAME', 'Name of the issue to operate on') do |issue_name|
          @options[:issue_name] = issue_name
        end
        options.on('-n', '--new', "Create a new issue for the current project\nCannot be specifed with -d or -s") do
          @options[:new] = true
        end
        options.on('-d', '--delete', "Delete an issue from the current project\nCannot be specified with -n or -s") do
          @options[:delete] = true
        end
        options.on('-s', '--show', "Display all the currently existing issues\nCannot be specified with -n or -d") do
          @options[:show] = true
        end
        options.on('-v', '--version', "Display the program version\nOverrides all other option behaviors") do
          @options[:version] = true
        end
        @options.on('-h', '--help', 'Displays a helpful usage guide') do
          puts @options
          exit
        end
      end.parse!
    end

    attr_reader :options
  end
end
