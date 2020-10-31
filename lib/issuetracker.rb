require 'issuetracker/version'
require 'issuetracker/cli'
require 'issuetracker/issue'
require 'issuetracker/fileio'
require 'issuetracker/project'
require 'issuetracker/allprojects'
module Issuetracker
  class Error < StandardError; end
  # I moved around and modified the code you had in bin/issuetracker, because that file
  # is just meant for making the program properly accessible via the shell. What you had
  # makes more sense to put in here, and to keep the 'best practices' structure we should
  # not modify bin/issuetracker much most likely, instead, program flow can be defined here
  # and specific subroutines or constants can be defined in classes or methods in the files in lib/issuetracker.
  file = FileIO.new
  all_projects = AllProjects.new
  all_projects.hash = file.read_json if File.exist?(file.path)
  puts all_projects.hash.display
  cli = CLI.new
  cli.main_menu
  cli.main_menu_input
  main_menu_selection = cli.main_menu_selection
  if %w[n new].include?(main_menu_selection)
    cli.new_issue_menu
    issue_definition = cli.new_issue_selection
    issue = Issue.new
    issue.setproject(issue_definition['Project name'])
    issue.setdescription(issue_definition['Description'])
    issue.setstatus(issue_definition['Status'])
    puts issue.hash.display
    project = Project.new
    project.setname(issue_definition['Project name'])
    project.setpath(Dir.pwd)
    project.addissue(issue.hash)
    puts project.hash.display
    all_projects.addproject(project.hash) if all_projects.hash[project.number].nil?
    puts all_projects.hash.display
    file.hash = all_projects.hash
    file.write_json
  end
end
