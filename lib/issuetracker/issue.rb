module Issuetracker
  class Issue
  # This class defines the structure of the 'Issue' hash object.
  # It initializes with default values that can be overridden by specifying ordered arguments at object instantiation.
  # Properties can be read using code such as issue = Issue.new; status = issue.status
  # Properties should be updated using the set methods defined in the class
  # because these methods will properly update the hash object while trying to modify the properties
  # directly will not.
  # The hash object can be modified directly if specifically needed but it is still recommendeded to use
  # the setter methods whenever possible instead.
    def initialize(name = 'New Issue', number = 1, project = 'Default project', status = 'Open', description = 'Description of the issue')
      @name = name
      @number = number
      @project = project
      @status = status
      @description = description
      @hash = { 'Name' => @name, 'Number' => @number, 'Project' => @project, 'Status' => @status, 'Description' => @description }
    end

    attr_accessor :hash
    attr_reader :name, :number, :project, :status, :description

    def setname(name)
      @name = name
      @hash['Name'] = @name
    end

    def setnumber(number)
      @number = number
      @hash['Number'] = @number
    end

    def setproject(project)
      @project = project
      @hash['Project'] = @project
    end

    def setstatus(status)
      @status = status
      @hash['Status'] = @status
    end

    def setdescription(description)
      @description = description
      @hash['Description'] = @description
    end
  end
end
