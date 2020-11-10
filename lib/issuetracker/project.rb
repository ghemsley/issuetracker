require 'issuetracker/path'
module Issuetracker
  # This class creates a new project with default values that can be overridden when instantiated with .new
  # It has methods for getting and setting the values of all its attributes, the setter methods for everything but @hash
  # will automatically update the hash
  #
  # Hash can be accessed using the .hash method, and can be modified directly with the .hash method too:
  # (project.hash = {key1: 'value1'} or project.hash['key'] = 'value')
  #
  # It is recommended not to use the .hash method to update the hash unless really necessary though
  # as this won't update the other instance variables. Use the setter methods that are defined already
  # instead when possible as this updates both the variable and hash at once
  #
  # The 'addissue' methods are special as it doesn't overwrite the @issues variable, instead it adds/removes a key to
  # or from the @issues hash then appends the @issues hash to project.hash automatically, attempting to update
  # the issue numbers if necessary.
  #
  # New Projects should be instantiated with Project.create instead of Project.new as .create keeps track of instances
  # using the @@all array
  #
  # This class can instantiate a set of existing Projects using the Project.create_from_projects_hash method which
  # expects the value at the :Projects key of the hash created by an instance of the FileIO class after reading
  # the user's .issuetracker.json file. Project instances created this way will be added to the @@all array
  # and their hashes will be appended to the class-level @@hash variable.
  class Project
    @@all = []                                # All instances of the Project class
    @@path = PATH                             # Path to our .issuetracker.json file
    @@project_count = @@all.length            # Total number of projects created so far
    @@total_issue_count = 0                   # Total number of issues created so far
    @@all_hash = {                            # A hash describing all Projects and some related metadata
      Path: PATH,                             # Path to .issuetracker.json
      Project_count: @@project_count,         # Total number of projects
      Total_issue_count: 0,                   # Total number of issues
      Projects: []                            # An array of Project hashes
    }
    attr_accessor :issue_count
    attr_reader :name, :number, :description, :path, :project_hash, :issues_array

    def initialize(
      name: 'Name of the project',                # Project name
      number: 1,                                  # Project number
      description: 'Description of the project',  # Project description
      path: Dir.pwd,                              # Project folder path
      issues_array: []                            # An array of issues to initialize the project with
    )
      @name = name
      @number = number
      @description = description
      @path = path
      @issues_array = issues_array
      @issue_count = self.issues_array.length # Number of issues for this project
      @project_hash = {                       # A hash descriibing this project and containing an array of its issues
        Name: name,
        Number: number,
        Description: description,
        Path: path,
        Issue_count: @issue_count,
        Issues: issues_array
      }

      @@project_count += 1                                                    # We are creating a project so increment the count
      @@total_issue_count += issue_count                                      # Increment total issue count by project issue count
      self.class.all_hash[:Project_count] = self.class.project_count          # Update the Projects hash with the current project count
      self.class.all_hash[:Total_issue_count] = self.class.total_issue_count  # Update the Projects hash with the current total issue count
      self.class.all_hash[:Projects].push(project_hash)                       # Add the current Project instance'ss hash to the array of Project hashes
    end

    # Name of the project
    def name=(name)
      @name = name
      project_hash[:Name] = self.name
    end

    # Number of the project
    def number=(number)
      @number = number
      project_hash[:Number] = self.number
    end

    # Description of the project
    def description=(description)
      @description = description
      project_hash[:Description] = self.description
    end

    # Path to the project directory
    def path=(path)
      @path = path
      project_hash[:Path] = self.path
    end

    # Expects an issue object: Adds its hash to the project's issue array and updates variables/project hash
    def add_issue(issue_object)
      issues_array.push(issue_object.issue_hash)
      self.issue_count = issues_array.length
      issue_object.number = issue_count
      project_hash[:Issues] = issues_array
      project_hash[:Issue_count] = issue_count
      @@total_issue_count += 1
      self.class.all_hash[:Total_issue_count] = self.class.total_issue_count
    end

    # Expects an issue object, adds its hash to Project instance hash and updates variables
    def remove_issue(issue_object)
      issues_array.delete_at(issue_object.issue_hash[:Number] - 1)
      issue_object.issue_hash[:Number] -= 1 unless issue_object.issue_hash[:Number] < 2
      self.issue_count = issues_array.length
      project_hash[:Issues] = issues_array
      project_hash[:Issue_count] = issue_count
      @@total_issue_count -= 1
      self.class.all_hash[:Total_issue_count] = self.class.total_issue_count
    end

    # An array containing all Project instances
    def self.all
      @@all
    end

    # The path to the user's .issuetracker.json file
    def self.path
      @@path
    end

    def self.path=(path)
      @@path = path
    end

    # The count of all projects
    def self.project_count
      all.length
    end

    # The count of all issues in all existing projects
    def self.total_issue_count
      @@total_issue_count
    end

    # A hash containing all projects and related metadata
    def self.all_hash
      @@all_hash
    end

    # Returns the array of all project hashes
    def self.projects_hash_array
      all_hash[:Projects]
    end

    # If project already exists, returns that, else creates a new Project instance and adds it to the @@all array
    # then returns a Project instance
    def self.create(
      name: 'Name of the project',
      number: 1,
      description: 'Description of the project',
      path: Dir.pwd,
      issues_array: []
    )
      existing_project = all.find do |project_element|
        project_element.path == path
      end
      if existing_project
        existing_project
      else
        project = new(
          name: name,
          number: number,
          description: description,
          path: path,
          issues_array: issues_array
        )
        all.push(project)
        all_hash[:Project_count] = project_count
        project
      end
    end

    # Creates Project instances from issuetracker.json hash and adds all project instances to @@all array, returns @@all
    def self.create_from_projects_hash(hash)
      hash.transform_keys!(&:to_sym) # Keys get converted to string at file write, so convert back to symbol
      unless hash[:Projects].empty?
        hash[:Projects].each do |project_element|
          project_element.transform_keys!(&:to_sym)
          project_element[:Issues].each do |issue_element|
            issue_element.transform_keys!(&:to_sym)
          end
        end
      end
      hash[:Projects].each do |project_hash_element|
        all.push(new(
                   name: project_hash_element[:Name],
                   number: project_hash_element[:Number],
                   description: project_hash_element[:Description],
                   path: project_hash_element[:Path],
                   issues_array: project_hash_element[:Issues]
                 ))
      end
      all_hash[:Project_count] = project_count
      all
    end
  end
end
