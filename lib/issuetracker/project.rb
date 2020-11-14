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
    attr_accessor :name, :number, :description, :path
    def initialize(
      name: 'Name of the project',                # Project name
      number: 1,
      description: 'Description of the project',  # Project description
      path: Dir.pwd                               # Project folder path
    )
      self.name = name
      self.number = number
      self.description = description
      self.path = path
      self.class.all.push(self)
    end

    def issues
      Issue.all.select do |issue|
        issue.project == self
      end
    end

    def issue_count
      issues.length
    end

    def issue_hashes
      issues.collect do |issue|
        issue.issue_hash
      end
    end

    # A hash descriibing this project and containing an array of its issues
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

    def self.path=(path)
      @@path = path
    end

    # The count of all projects
    def self.project_count
      all.length
    end

    # The count of all issues in all existing projects
    def self.total_issue_count
      Issue.all.reject do |issue|
        issue.project.nil?
      end.length
    end

    # A hash containing all project hashes and related metadata
    def self.mega_hash
      {
        Path: path,
        Project_count: project_count,
        Total_issue_count: total_issue_count,
        Projects: project_hashes
      }
    end

    # Returns the array of all project hashes
    def self.project_hashes
      all.collect do |project|
        project.project_hash
      end
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
    # Takes in hash, returns hash with keys as symbols
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
          number: project_count + 1,
          description: project_hash[:Description],
          path: project_hash[:Path]
        )
        project_hash[:Issues].each do |issue_hash|
          Issue.new(
            name: issue_hash[:Name],
            number: project.issue_count + 1,
            project: project,
            status: issue_hash[:Status],
            description: issue_hash[:Description]
          )
        end
      end
      all
    end
  end
end
