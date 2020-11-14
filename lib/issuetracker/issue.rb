module Issuetracker
  # This class defines the structure of the 'Issue' hash object.
  # It initializes with default values that can be overridden by specifying ordered arguments at object instantiation.
  # Properties can be read using code such as issue = Issue.new; status = issue.status
  # Properties should be updated using the set methods defined in the class
  # because these methods will properly update the hash object while trying to modify the properties
  # directly might not.
  class Issue
    @@all = []
    attr_accessor :name, :number, :project, :status, :description
    def initialize(
      name: 'New Issue',
      number: 1,
      project: nil,
      status: 'Open',
      description: 'Description of the issue'
    )
      self.name = name
      self.number = number
      self.project = project
      self.status = status
      self.description = description
      self.class.all.push(self)
    end

    def issue_hash
      {
        Name: name,
        Number: number,
        Project: project.name,
        Status: status,
        Description: description
      }
    end

    def self.all
      @@all
    end
  end
end
