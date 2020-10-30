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
    def initialize(name = 'New Project', number = 1, description = 'Description of the project', path = './', issues = {})
      @name = name
      @number = number
      @description = description
      @path = path
      @issues = issues
      @hash = { 'Name' => @name, 'Number' => @number, 'Description' => @description, 'Path' => @path, 'Issues' => @issues }
    end

    attr_accessor :hash
    attr_reader :name, :number, :description, :path

    def setname(name)
      @name = name
      @hash['Name'] = @name
    end

    def setnumber(number)
      @number = number
      @hash['Number'] = @number
    end

    def setdescription(description)
      @description = description
      @hash['Description'] = @description
    end

    def setpath(path)
      @path = path
      @hash['Path'] = @path
    end

    def addissue(issue)
      issue_number = issue['Number']
      if @issues != {}
        while @issues[number].exists?
          issue_number = @issues.find do |key, value|
            key.instance_of?(Integer) && value.instance_of?(Hash) && key >= issue_number
          end
          issue_number += 1
        end
      end
      @issues[issue_number] = issue
      @hash['Issues'] = @issues
    end

    def removeissue(issue)
      issue_number = issue['Number']
      @issues.delete(issue_number) if @issues[issue_number].exists?
      @issues = @issues.collect do |key, value|
        key -= 1 if key.instance_of?(Integer) && value.instance_of?(Hash) && key > issue_number && key > 1
      end
      @hash['Issues'] = @issues
    end
  end
end
