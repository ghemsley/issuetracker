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
  if File.exist?(file.path)
    all_projects.hash = file.read_json
    all_projects.normalize_self
  end
  cli = CLI.new(all_projects.total_issue_count, all_projects.projects_array)
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
    project = Project.new
    project.setname(issue_definition['Project name'])
    project_hash = all_projects.projects_array.find do |element|
      element[:Name] == issue.project
    end
    if project_hash.nil?
      project.addissue(issue.hash)
      all_projects.addproject(project.hash)
    else
      project.hash = project_hash
      project.hash[:Issues].each do |element|
        project.addissue(element)
      end
      project.addissue(issue.hash)
      all_projects.updateproject(project.hash)
    end
    file.hash = all_projects.hash
    file.write_json
  end
end
