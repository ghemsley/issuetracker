module Issuetracker
  class CLI
    def initialize(
      issue_count = 0,
      existing_projects = [],
      project_name_input = 'Project name',
      project_description_input = 'Project description',
      issue_name_input = 'Issue name',
      issue_description_input = 'Issue description',
      issue_status_input = 'Issue status'
    )
      @main_menu_selection = nil
      @new_issue_selection = {}
      @issue_count = issue_count
      # for checking project name against existing projects
      @current_path = Dir.pwd
      @existing_projects = existing_projects
      # new issue input
      @project_name_input = project_name_input
      @project_description_input = project_description_input
      @issue_name_input = issue_name_input
      @issue_description_input = issue_description_input
      @issue_status_input = issue_status_input
    end

    attr_accessor :issue_count,
                  :existing_project_paths

    attr_reader :main_menu_selection,
                :new_issue_selection,
                :current_path,
                :project_name_input,
                :issue_name_input,
                :issue_description_input,
                :issue_status_input

    def main_menu
      system 'clear'
      puts "
╔══════════════════════════════════════════════════════════════════╗

  888                          88888                8
   8  d88b d88b 8   8 .d88b      8   8d8b .d88 .d8b 8.dP .d88b 8d8b
   8  `Yb. `Yb. 8b d8 8.dP'      8   8P   8  8 8    88b  8.dP' 8P
  888 Y88P Y88P `Y8P8 `Y88P      8   8    `Y88 `Y8P 8 Yb `Y88P 8

╚══════════════════════════════════════════════════════════════════╝

┌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┐     ┌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┐     ┌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┐
     New Issue            View by Projects         Archived Issues
     New or N               Project or P            Archived or A
└╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┘     └╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┘     └╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┘"
    end

    def main_menu_input
      @main_menu_selection = gets.strip.downcase
      if %w[n new].include?(@main_menu_selection)
        @main_menu_selection
      elsif %w[p project].include?(@main_menu_selection)
        # view by projects
        @main_menu_selection
      elsif %w[a archived].include?(@main_menu_selection)
        # view by archived status
        puts 'Archived issues'
        @main_menu_selection
      else
        puts 'Please make a valid entry. (New/N, Project/P, Archived/A)'
        main_menu_input
      end
      @main_menu_selection
    end

    def new_issue_banner
      puts '╔═══════════════════╗'
      puts "   Issue number: #{@issue_count}"
      puts '╚═══════════════════╝'
    end

    def get_project_name_input
      @existing_projects.each do |project_element|
        return project_element[:Name] if project_element[:Path] == @current_path && !project_element[:Name].nil?
      end
      system 'clear'
      new_issue_banner
      puts 'Input a name for your project or input -p or -projects to view current projects: '
      @project_name_input = gets.strip
      taken = @existing_projects.find do |project_element|
        project_element[:Name].downcase == @project_name_input.downcase && project_element[:Path] != @current_path
      end
      if taken
        puts "The name '#{@project_name_input}' is taken by another project."
        puts 'Please choose a different name for your project,'
        puts 'or navigate to the directory containing the existing project'
        puts 'and run Issuetracker again to modify that project\'s issues.'
        get_project_name_input
      end
      @project_name_input
    end

    def get_project_description_input
      @existing_projects.each do |project_element|
        if project_element[:Path] == @current_path && !project_element[:Description].nil?
          return project_element[:Description]
        end
      end
      system 'clear'
      new_issue_banner
      puts "Project name: #{@project_name_input}"
      puts 'Input a description for your project:'
      @project_description_input = gets.strip
      taken = @existing_projects.find do |project_element|
        project_element[:Description].downcase == @project_description_input.downcase && project_element[:Path] != @current_path
      end
      if taken
        puts "The description '#{@project_description_input}' matches another project."
        puts 'Please choose a different description for your project,'
        puts 'or navigate to the directory containing the existing project'
        puts 'and run Issuetracker again to modify that project\'s issues.'
        get_project_description_input
      end
      @project_description_input
    end

    def get_issue_name_input
      system 'clear'
      new_issue_banner
      puts "Project name: #{@project_name_input}"
      puts "Project description: #{@project_description_input}"
      puts 'Input a name for your issue:'
      @issue_name_input = gets.strip
      matching = false
      @existing_projects.each do |project_element|
        matching = project_element[:Issues].find do |issue_element|
          issue_element[:Name].downcase == @issue_name_input.downcase
        end
      end
      if matching
        puts "The name '#{@issue_name_input}' matches an existing issue in this project."
        puts 'Please choose a different name for your issue.'
        get_issue_name_input
      end
      @issue_name_input
    end

    def get_issue_description_input
      system 'clear'
      new_issue_banner
      puts "Project name: #{@project_name_input}"
      puts "Project description: #{@project_description_input}"
      puts "Issue name: #{@issue_name_input}"
      puts 'Input a description for your issue:'
      @issue_description_input = gets.strip
      matching = false
      @existing_projects.each do |project_element|
        matching = project_element[:Issues].find do |issue_element|
          issue_element[:Description].downcase == @issue_description_input.downcase
        end
      end
      if matching
        puts "The description '#{@issue_description_input}' matches an existing issue in this project."
        puts 'Please choose a different description for your issue.'
        get_issue_description_input
      end
      @issue_description_input
    end

    def get_issue_status_input
      system 'clear'
      new_issue_banner
      puts "Project name: #{@project_name_input}"
      puts "Project description: #{@project_description_input}"
      puts "Issue name: #{@issue_name_input}"
      puts "Issue description: #{@issue_description_input}"
      puts 'Input a status for the issue (Open/Closed/Later):'
      @issue_status_input = gets.strip
      unless %w[open closed later].include?(@issue_status_input.downcase)
        puts 'Please select a status of Open, Closed, or Later'
        get_issue_status_input
      end
      @issue_status_input
    end

    def new_issue_menu
      @issue_count += 1
      @project_name_input = get_project_name_input
      @project_description_input = get_project_description_input
      @issue_name_input = get_issue_name_input
      @issue_description_input = get_issue_description_input
      @issue_status_input = get_issue_status_input
      system 'clear'
      new_issue_banner
      puts "Project name: #{@project_name_input}"
      puts "Project description: #{@project_description_input}"
      puts "Issue name: #{@issue_name_input}"
      puts "Issue description: #{@issue_description_input}"
      puts "Issue status: #{@issue_status_input}"
      @new_issue_selection['Project name'] = @project_name_input
      @new_issue_selection['Project description'] = @project_description_input
      @new_issue_selection['Issue name'] = @issue_name_input
      @new_issue_selection['Issue description'] = @issue_description_input
      @new_issue_selection['Issue status'] = @issue_status_input
      @new_issue_selection
    end
  end
end
