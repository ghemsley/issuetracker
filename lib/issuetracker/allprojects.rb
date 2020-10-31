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
    def initialize(path = "#{Dir.home}/.issuetracker", project_count = 0, projects = {})
      @path = path
      @project_count = project_count
      @projects = projects
      @hash = { 'Path' => @path, 'Project count' => @project_count, 'Projects' => @projects }
    end

    attr_accessor :hash
    attr_reader :path, :project_count, :projects

    def setpath(path)
      @path = path
      @hash['Path'] = @path
    end

    def addproject(project)
      project_number = project['Number']
      if @projects != {}
        while @projects[project_number].exists?
          project_number = @projects.find do |key, value|
            key.instance_of?(Integer) && value.instance_of?(Hash) && key >= project_number
          end
          project_number += 1
        end
      end
      @projects[project_number] = project
      @project_count += 1
      @hash['Projects'].merge(@projects)
      @hash['Project count'] = @project_count
    end

    def updateproject(project)
      project_number = project['Number']
      if !@projects[project_number].nil?
        @projects[project_number].merge(project)
      else
        @projects[project_number] = project
      end
      @hash['Projects'][project_number] = project
    end

    def removeproject(project)
      project_number = project['Number']
      @projects.delete(project_number) if @projects[project_number].exists?
      @projects = @projects.collect do |key, value|
        key -= 1 if key.instance_of?(Integer) && value.instance_of?(Hash) && key > project_number && key > 1
      end
      @project_count -= 1
      @hash['Projects'] = @projects
      @hash['Project count'] = @project_count
    end
  end
end
