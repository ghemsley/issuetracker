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
        opts.on('-c', '--category ISSUE_CATEGORY', 'Name of the category to display or operate on. Requires -s, -n, -u, or -d') do |issue_category|
          @options[:category] = issue_category
        end
        opts.on('-i', '--issue ISSUE_NAME', 'Name of the issue to operate on') do |name|
          @options[:name] = name
        end
        opts.on('-e', '--explanation ISSUE_DESCRIPTION', 'Description of the issue') do |content|
          @options[:content] = content
        end
        opts.on('-s', '--show', 'Display all the currently existing issues. Defaults to project in current directory unless used with -p. Cannot be used with -n or -d') do
          @options[:show] = true
        end
        opts.on('-n', '--new', 'Create a new issue. Defaults to project in current directory if it exists and -p not specified. Cannot be used with -d, -u or -s') do
          @options[:new] = true
        end
        opts.on('-u', '--update', 'Update an issue. Defaults to project in current directory if it exists and -p not specified. Cannot be used with -n, -d or -s') do
          @options[:update] = true
        end
        opts.on('-d', '--delete', 'Delete an issue or category of issues. Defaults to project in current directory if -p not specified. Cannot be used with -n, -u  or -s') do
          @options[:delete] = true
        end
        opts.on('-v', '--version', 'Display the program version. Overrides all other option behaviors') do
          puts VERSION
          exit
        end
        opts.on('-h', '--help', 'Displays a helpful usage guide. Overrides all other option behaviors') do
          puts opts
          exit
        end
      end.parse!
    end

    attr_reader :options
  end
end
