require 'issuetracker/version'
require 'issuetracker/cli'
require 'issuetracker/issue'
require 'issuetracker/fileio'
module Issuetracker
  class Error < StandardError; end

  cli = CLI.new
  if (cli.options[:delete] && cli.options[:new] && cli.options[:show] && cli.options[:update]) ||
     (cli.options[:delete] && cli.options[:new] && cli.options[:update]) ||
     (cli.options[:delete] && cli.options[:show] && cli.options[:new]) ||
     (cli.options[:new] && cli.options[:show] && cli.options[:update]) ||
     (cli.options[:new] && cli.options[:show]) ||
     (cli.options[:new] && cli.options[:update]) ||
     (cli.options[:new] && cli.options[:delete]) ||
     (cli.options[:delete] && cli.options[:update]) ||
     (cli.options[:delete] && cli.options[:show]) ||
     (cli.options[:update] && cli.options[:show])
    raise Error, "Incompatible option combination\n\nTry using the -h option flag for help"
  elsif cli.options[:version]
    puts VERSION
  elsif cli.options[:new]
    issue = Issue.new
    issue.setname(cli.options[:name]) if cli.options[:name]
    issue.setcategory(cli.options[:category]) if cli.options[:category]
    issue.setcontent(cli.options[:content]) if cli.options[:content]
    file = FileIO.new(issue.hash)
    file.path = cli.options[:project_path] if cli.options[:project_path]
    file.hash = issue.hash
    if cli.options[:project_path]
      file.write(cli.options[:project_path])
    else
      file.write
    end
  end
end
