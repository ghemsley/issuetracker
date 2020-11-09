require 'issuetracker/version'
require 'issuetracker/cli'
require 'issuetracker/issue'
require 'issuetracker/fileio'
require 'issuetracker/project'
require 'issuetracker/path'
module Issuetracker
  class Error < StandardError; end
  # I moved around and modified the code you had in bin/issuetracker, because that file
  # is just meant for making the program properly accessible via the shell. What you had
  # makes more sense to put in here, and to keep the 'best practices' structure we should
  # not modify bin/issuetracker much most likely, instead, program flow can be defined here
  # and specific subroutines or constants can be defined in classes or methods in the files in lib/issuetracker.
  file = FileIO.new
  if File.exist?(file.path)
    projects_hash = file.read_json
    Project.create_from_projects_hash(projects_hash)
  end
  cli = CLI.new(
    issue_count: Project.total_issue_count,
    existing_projects: Project.hash[:Projects]
  )
  cli.main_menu
  cli.main_menu_input
  main_menu_selection = cli.main_menu_selection
  if %w[n new].include?(main_menu_selection)
    cli.new_issue_menu
    issue_definition = cli.new_issue_selection
    issue = Issue.new(
      name: issue_definition['Issue name'],
      project: issue_definition['Project name'],
      description: issue_definition['Issue description'],
      status: issue_definition['Issue status']
    )
    project = Project.create(
      name: issue_definition['Project name'],
      number: Project.project_count + 1,
      description: issue_definition['Project description']
    )
    project.addissue(issue.hash)
    file.hash = Project.hash
    file.write_json
  end
end
