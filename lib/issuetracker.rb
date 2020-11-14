require 'issuetracker/version'
require 'issuetracker/cli'
require 'issuetracker/issue'
require 'issuetracker/fileio'
require 'issuetracker/project'
require 'issuetracker/path'
module Issuetracker
  # Leaving this here for later
  class Error < StandardError; end
  file = FileIO.new # Instantiate a new FileIO object with the default path
  if File.exist?(file.path) # Does a file already exist at the default path?
    projects_hash = file.read_json # Read json from file, converting it to a hash
    Project.create_from_projects_hash(projects_hash) # Create Project instances from that hash
  end
  cli = CLI.new(
    issue_count: Project.total_issue_count, # Instantiate a new CLI object that keeps track of the total issue count
    existing_projects: Project.projects_hash_array # Also make sure it knows about existing projects
  )
  cli.main_menu # Show the main menu banner
  cli.main_menu_input # Ask user what menu to proceed to
  main_menu_selection = cli.main_menu_selection # Get main menu user input from CLI object
  if %w[n new].include?(main_menu_selection) # If the user chose to create a new issue
    cli.new_issue_menu # Show the prompts for creating a new issue (if project doesn't exist yet, get input for creating that too)
    issue_definition = cli.new_issue_selection # Get new issue menu user input from CLI object
    issue = Issue.new( # Create a new issue with the user's input as arguments
      name: issue_definition['Issue name'],
      project: issue_definition['Project name'], # If in an existing project directory, this will be set to the existing project's name
      description: issue_definition['Issue description'],
      status: issue_definition['Issue status']
    )
    project = Project.create( # Create a new project with the user's new issue menu input
      name: issue_definition['Project name'],
      number: Project.project_count + 1, # We are adding a new project so increment the project number (handles existing projects properly)
      description: issue_definition['Project description'] # If in an existing project directory, this will be set to that project's description
    )
    project.add_issue(issue) # Add issue to the project
    file.projects_hash = Project.all_hash # Set the hash for writing to file to the Project class mega-hash
    file.write_json # Write that hash to a file as JSON
  end
end
