require 'issuetracker/path'
module Issuetracker
  # This class creates a new project with default values that can be overridden when instantiated with its constructor 
  # methods
  #
  # It has methods for getting and setting the values of many of its attributes, the setter methods will automatically 
  # update the @hash instance variable
  #
  #
  # It is recommended not to use the .project_hash method to update the hash unless really necessary
  # as this won't update the other instance variables. Use the setter methods that are defined already
  # instead when possible as this updates both the variable and hash at once
  #
  # It is recommended to use Project.find_or_create_by_path instead of Project.new when applicable because this 
  # checks automatically for existing projects in the current working directory, whereas .new does not
  #
  # This class can instantiate a set of existing Projects using the Project.create_from_mega_hash method which
  # creates new Project and Issue instances for you by reading the file at the path set in the Project.path variable
  # (.issuetracker.json in the home directory by default). Project and Issue instances created this way will be added
  # to the @@all arrays and their hashes will be included in Project.mega_hash
  #
  # Note that there are two .path variables, one at class level and one at instance level.
  # The class level path is meant to point to the user's .issuetracker.json file while the instance level path
  # should point to the intended project directory to instantiate a Project instance for.
  class Project
    @@all = []                                # All instances of the Project class
    @@path = PATH                             # Path to our .issuetracker.json file (Alert! Different from the instance level path)
    attr_accessor :name, :number, :description, :path
    def initialize(
      name: 'Name of the project',                # Project name
      number: 1,                                  # Project number
      description: 'Description of the project',  # Project description
      path: Dir.pwd                               # Project folder path (Alert! Different than Project.path)
    )
      self.name = name
      self.number = number
      self.description = description
      self.path = path # Alert! Different than Project.path
      self.class.all.push(self)
    end

    # Returns an array of all the issues that belong to this project (have this instance set as its project)
    def issues
      Issue.all.select do |issue|
        issue.project == self
      end
    end


    # The number of issues belonging to this Project instance
    def issue_count
      issues.length
    end

    # Returns an array of all the hashes of this project instance's issues
    def issue_hashes
      issues.collect do |issue|
        issue.issue_hash
      end
    end

    # A hash descriibing this project and containing an array of its issues' hashes
    def project_hash
      {
        Name: name,
        Number: number,
        Description: description,
        Path: path,
        Issue_count: issue_count,
        Issues: issue_hashes
      }
    end

    # Expects an issue object, returns added issue
    def add_issue(issue)
      issue.project = self
      issue
    end

    # Expects an issue object, returns removed issue
    def remove_issue(issue)
      issue.project = nil
      issue
    end

    # An array containing all Project instances
    def self.all
      @@all
    end

    # The path to the user's .issuetracker.json file
    def self.path
      @@path
    end

    # Can change the path to the user's .issuetracker.json file
    def self.path=(path)
      @@path = path
    end

    # The count of all projects
    def self.project_count
      all.length
    end

    # The count of all issues in all existing Project instances
    def self.total_issue_count
      Issue.all.reject do |issue|
        issue.project.nil?
      end.length
    end

    # Returns an array of all project hashes
    def self.project_hashes
      all.collect do |project|
        project.project_hash
      end
    end

    # Returns a hash containing all project hashes and related metadata
    def self.mega_hash
      {
        Path: path,
        Project_count: project_count,
        Total_issue_count: total_issue_count,
        Projects: project_hashes
      }
    end

    # If project already exists for path, returns that, else creates and returns a new Project instance
    def self.find_or_create_by_path(
      name: 'Name of the project',
      number: 1,
      description: 'Description of the project',
      path: Dir.pwd
    )
      existing_project = all.find do |project|
        project.path == path
      end
      existing_project || new(
        name: name,
        number: number,
        description: description,
        path: path
      )
    end

    # Keys get converted to string at file write, so convert back to symbol
    #
    # Accepts hash argument, returns hash with keys as symbols
    def self.normalize_hash(hash)
      hash.transform_keys!(&:to_sym)
      unless hash[:Projects].empty?
        hash[:Projects].each do |project|
          project.transform_keys!(&:to_sym)
          project[:Issues].each do |issue|
            issue.transform_keys!(&:to_sym)
          end
        end
      end
      hash
    end

    # Creates Project instances from issuetracker.json hash and adds all project instances to @@all, returns @@all
    def self.create_from_mega_hash(hash)
      normalize_hash(hash)
      hash[:Projects].each do |project_hash|
        project = new(
          name: project_hash[:Name],
          number: project_count + 1, # Whenever we create a new project, we want to set its number to the count of all projects + 1
          description: project_hash[:Description],
          path: project_hash[:Path]
        )
        project_hash[:Issues].each do |issue_hash|
          Issue.new(
            name: issue_hash[:Name],
            number: project.issue_count + 1, # Whenever we create a new issue we want to get the current Project instances issue count and add 1
            project: project, # This is a project object, not a project hash or project name!
            status: issue_hash[:Status],
            description: issue_hash[:Description]
          )
        end
      end
      all
    end
  end
end
