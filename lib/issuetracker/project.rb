module Issuetracker
  # This class creates a new project with default values that can be overridden when instantiated with .new
  # It has methods for getting and setting the values of all its attributes, the setter methods for everything but @hash
  # will automatically update the hash
  # Hash can be accessed using the .hash method, and can be modified directly with the .hash method too (project.hash = {key1: 'value1'}
  # or project.hash['key'] = 'value')
  # It is recommended not to use the .hash method to update the hash unless really necessary though
  # as this won't update the other instance variables. Use the setter methods that are defined already
  # instead when possible as this updates both the variable and hash at once
  # the 'addissue' methods are special as it doesn't overwrite the @issues variable, instead it adds/removes a key to or from
  # the @issues hash then appends the @issues hash to project.hash automatically, attempting to update the issue numbers if necessary.
  class Project
    def initialize(name = 'New Project', number = 0, description = 'Description of the project', path = Dir.pwd, issues_array = [])
      @name = name
      @number = number
      @description = description
      @path = path
      @issues_array = issues_array
      @issue_count = @issues_array.length
      @hash = { Name: @name, Number: @number, Description: @description, Path: @path, Issue_count: @issue_count, Issues: @issues_array }
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
    end

    def removeissue(issue)
      issue_number = issue[:Number]
      @issues_array.delete_at(issue_number)
      issue[:Number] -= 1 unless issue[:Number] < 1
      @issue_count = @issues_array.length
      @hash[:Issues] = @issues_array
      @hash[:Issue_count] = @issue_count
    end
  end
end
