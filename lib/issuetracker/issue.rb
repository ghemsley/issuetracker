module Issuetracker
  # This class defines the structure of the 'Issue' hash object.
  # It initializes with default values that can be overridden by specifying ordered arguments at object instantiation.
  # Properties can be read using code such as issue = Issue.new; status = issue.status
  # Properties should be updated using the set methods defined in the class
  # because these methods will properly update the hash object while trying to modify the properties
  # directly might not.
  class Issue
    attr_reader :name, :number, :project, :status, :description, :issue_hash

    def initialize(
      name: 'New Issue',
      number: 1,
      project: 'Default project',
      status: 'Open',
      description: 'Description of the issue'
    )
      @name = name
      @number = number
      @project = project
      @status = status
      @description = description
      @issue_hash = {
        Name: self.name,
        Number: self.number,
        Project: self.project,
        Status: self.status,
        Description: self.description
      }
    end

    def name=(name)
      @name = name
      issue_hash[:Name] = self.name
    end

    def number=(number)
      @number = number
      issue_hash[:Number] = self.number
    end

    def project=(project)
      @project = project
      issue_hash[:Project] = self.project
    end

    def status=(status)
      @status = status
      issue_hash[:Status] = self.status
    end

    def description=(description)
      @description = description
      issue_hash[:Description] = self.description
    end
  end
end
