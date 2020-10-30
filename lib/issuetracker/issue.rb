module Issuetracker
  class Issue
    def initialize(name = 'New Issue', project = 'Default project', status = 'Active', description = 'Description of the issue')
      @name = name
      @project = project
      @status = status
      @description = description
      @hash = { 'Name' => @name, 'Project' => @project, 'Status' => @status, 'Description' => @description }
    end
    
    attr_accessor :hash
    attr_reader :name, :project, :status, :description

    def setname(name)
      @name = name
      @hash['Name'] = @name
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
