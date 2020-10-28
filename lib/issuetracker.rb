require 'issuetracker/version'
require 'issuetracker/cli'
require 'issuetracker/workspace'
module Issuetracker
  class Error < StandardError; end

  cli = CLI.new
  if (cli.options[:delete] && cli.options[:new] && cli.options[:show]) ||
     (cli.options[:delete] && cli.options[:new]) ||
     (cli.options[:delete] && cli.options[:show]) ||
     (cli.options[:new] && cli.options[:show])
    raise Error, "Incompatible option combination\nTry using the -h option flag for help"
  elsif cli.options[:version]
    puts VERSION
  end
end
