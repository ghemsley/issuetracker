require 'issuetracker/path'
module Issuetracker
  # This class creates a new project with default values that can be overridden when instantiated with .new
  # It has methods for getting and setting the values of all its attributes, the setter methods for everything but @hash
  # will automatically update the hash
  # Hash can be accessed using the .hash method, and can be modified directly with the .hash method too:
  # (project.hash = {key1: 'value1'} or project.hash['key'] = 'value')
  # It is recommended not to use the .hash method to update the hash unless really necessary though
  # as this won't update the other instance variables. Use the setter methods that are defined already
  # instead when possible as this updates both the variable and hash at once
  # the 'addissue' methods are special as it doesn't overwrite the @issues variable, instead it adds/removes a key to
  # or from the @issues hash then appends the @issues hash to project.hash automatically, attempting to update
  # the issue numbers if necessary.
  class Project
    @@all = []
    @@path = PATH
    @@project_count = 0
    @@total_issue_count = 0
    @@hash = { Path: PATH, Project_count: 0, Total_issue_count: 0, Projects: [] }
    def initialize(
      name: 'Name of the project',
      number: 1,
      description: 'Description of the project',
      path: Dir.pwd,
      issues_array: []
    )
      @name = name
      @number = number
      @description = description
      @path = path
      @issues_array = issues_array
      @issue_count = @issues_array.length
      @hash = {
        Name: name,
        Number: number,
        Description: description,
        Path: path,
        Issue_count: @issue_count,
        Issues: issues_array
      }

      @@project_count += 1
      @@total_issue_count += @issue_count
      @@hash[:Project_count] = @@project_count
      @@hash[:Total_issue_count] = @@total_issue_count
      @@hash[:Projects].push(@hash)
    end

    attr_accessor :hash, :issues_array
    attr_reader :name, :number, :description, :path, :issue_count

    def setname(name)
      @name = name
      @hash[:Name] = @name
    end

    def setnumber(number)
      @number = number
      @hash[:Number] = @number
    end

    def setdescription(description)
      @description = description
      @hash[:Description] = @description
    end

    def setpath(path)
      @path = path
      @hash[:Path] = @path
    end

    def addissue(issue)
      @issues_array.push(issue)
      @issue_count = @issues_array.length
      issue[:Number] = @issue_count
      @hash[:Issues] = @issues_array
      @hash[:Issue_count] = @issue_count
      @@total_issue_count += 1
      @@hash[:Total_issue_count] = self.class.total_issue_count
    end

    def removeissue(issue)
      issue_number = issue[:Number]
      @issues_array.delete_at(issue_number)
      issue[:Number] -= 1 unless issue[:Number] < 1
      @issue_count = @issues_array.length
      @hash[:Issues] = @issues_array
      @hash[:Issue_count] = @issue_count
      @@total_issue_count -= 1
      @@hash[:Total_issue_count] = self.class.total_issue_count
    end

    def self.all
      @@all
    end

    def self.path
      @@path
    end

    def self.path=(path)
      @@path = path
    end

    def self.project_count
      all.length
    end

    def self.total_issue_count
      @@total_issue_count
    end

    def self.hash
      @@hash
    end

    def self.projects_hash_array
      hash[:Projects]
    end

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
        project
      end
    end

    def self.create_from_projects_hash(hash)
      hash.transform_keys! do |key|
        key.to_sym
      end
      unless hash[:Projects].empty?
        hash[:Projects].each do |project_element|
          project_element.transform_keys! do |key|
            key.to_sym
          end
          project_element[:Issues].each do |issue_element|
            issue_element.transform_keys! do |key|
              key.to_sym
            end
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
      all
    end
  end
end
