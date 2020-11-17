module Issuetracker
  # This class mainly defines the structure of the 'Issue' hash object.
  # It initializes with default values that can be overridden by specifying key arguments at object instantiation
  # or using setters
  #
  # Hash should be updated using the setter methods defined in the class because these methods will properly
  # update the hash object as well as the respective variable while trying to modify the hash values directly will not.
  class Issue
    @@all = []
    attr_accessor :name, :number, :project, :status, :description
    def initialize(
      name: 'New Issue', # Issue name
      number: 1, # Issue number
      project: nil, # If project is nil this issue will be an "orphan" with no project until it is set to a valid Project instance
      status: 'Open', # Issue status
      description: 'Description of the issue' # Issue description
    )
      self.name = name
      self.number = number
      self.project = project # This issue belongs to that project, while that project may have many issues
      self.status = status
      self.description = description
      self.class.all.push(self) # Add itself to @@all array
    end

    def issue_hash
      {
        Name: name,
        Number: number,
        Project: project.name, # Get just the project name, not the whole project object!
        Status: status,
        Description: description
      }
    end

    # Returns an array of all Issue instances created so far
    def self.all
      @@all
    end
  end
end
