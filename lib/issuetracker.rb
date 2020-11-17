require 'issuetracker/fileio'
require 'issuetracker/project'
require 'issuetracker/issue'
require 'issuetracker/cli'
module Issuetracker
  file = FileIO.new # Instantiate a new FileIO object with the default path
  if File.exist?(file.path) # Does a file already exist at the default path?
    mega_hash = file.read_json # Read json from file, converting it to a hash
    Project.create_from_mega_hash(mega_hash) # Create Project instances from that hash
  end
  cli = CLI.new
  cli.main_menu # Show the main menu banner
  cli.main_menu_input # Ask user what menu to proceed to
  main_menu_selection = cli.main_menu_selection # Get main menu user input from CLI object
  if %w[n new].include?(main_menu_selection) # If the user chose to create a new issue
    cli.new_issue_menu # Show the prompts for creating a new issue (if project doesn't exist yet, get project info as well)
    issue_def = cli.new_issue_selection # Get new issue menu user input from CLI object
    project = Project.find_or_create_by_path( # Create a new project with the user's new issue menu input at the default path
      name: issue_def[:project_name], # If in an existing project dir, will be set to that project's name
      number: Project.project_count + 1, # Add one to project count for project number because we are initalizing a new project
      description: issue_def[:project_description] # If in an existing project dir, will be set to that project's desc
    )
    issue = Issue.new( # Create a new issue with the user's input as arguments
      name: issue_def[:issue_name],
      number: project.issue_count + 1, # Add one to issue count for issue number because we are initalizing a new issue
      project: project, # If in an existing project directory, this will point to that project's Project instance
      description: issue_def[:issue_description],
      status: issue_def[:issue_status]
    )
    file.mega_hash = Project.mega_hash # Set the hash for writing to file to the Project class mega-hash
    file.write_json # Write that hash to a file as JSON
  end
end
