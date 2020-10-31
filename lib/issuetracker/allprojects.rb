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
  class AllProjects
    def initialize(path = "#{Dir.home}/.issuetracker", project_count = 0, projects_array = [], hash = {})
      @path = path
      @projects_array = projects_array
      @project_count = @projects_array.length
      @hash = { Path: @path, Project_count: @project_count, Projects: @projects_array }
    end

    attr_accessor :path, :projects_array, :project_count, :hash

    def setpath(path)
      @path = path
      @hash['Path'] = @path
    end

    def addproject(project)
      @projects_array.push(project)
      @hash[:Projects] = @projects_array
      @project_count = projects_array.length
      project[:Number] = @project_count
      @hash[:Project_count] = @project_count
    end

    def updateproject(project)
      project_number = project[:Number]
      @projects_array[project_number] = project
      @hash[:Projects] = @projects_array
    end

    def removeproject(project)
      project_number = project[:Number]
      @projects_array.delete_at(project_number)
      @project_count = @projects_array.length
      project[:Number] -= 1 unless project[:Number] < 1
      @hash[:Projects] = @projects_array
      @hash[:Project_count] = @project_count
    end
  end
end
