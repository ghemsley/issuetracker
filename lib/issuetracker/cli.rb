module Issuetracker
  class CLI
    def initialize(issue_count = 1)
      @main_menu_selection = nil
      @new_issue_selection = {}
      @issue_count = issue_count
    end

    attr_reader :main_menu_selection, :new_issue_selection, :issue_count

    def main_menu
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
└╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┘     └╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┘     └╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┘
"
    end

    def main_menu_input
      @main_menu_selection = gets.strip.downcase
      if @main_menu_selection == 'new' || @main_menu_selection == 'n'
        @main_menu_selection
      elsif @main_menu_selection == 'project' || @main_menu_selection == 'p'
        # view by projects
        @main_menu_selection
      elsif @main_menu_selection == 'archived' || @main_menu_selection == 'a'
        # view by archived status
        puts 'Archived issues'
        @main_menu_selection
      else
        puts 'Please make a valid entry. (New/N, Project/P, Archived/A)'
        main_menu_input
      end
      @main_menu_selection
    end

    def new_issue_menu
      puts "
╔═══════════════════╗
  Issue: #{@issue_count}
╚═══════════════════╝
Input a name for your project or input -p or -projects to view current projects:
"
      project_name_input = gets.strip
      puts "
╔═══════════════════╗
  Issue: #{@issue_count}
╚═══════════════════╝
Project: #{project_name_input}
Input a description for your project issue:
      "
      desc_input = gets.strip
      check_status_input = lambda do
        puts "
╔═══════════════════╗
  Issue: #{@issue_count}
╚═══════════════════╝
Project: #{project_name_input}
Description: #{desc_input}
Input a status for issue (Open/Closed/Later):
      "
        status_input = gets.strip.downcase
        unless %w[open closed later].include?(status_input)
          puts 'Please select a status of Open, Closed, or Later'
          check_status_input.call
        end
        return status_input
      end
      status_input = check_status_input.call
      puts "
╔═══════════════════╗
  Issue: #{@issue_count}
╚═══════════════════╝
Project: #{project_name_input}
Description: #{desc_input}
Status: #{status_input}
"
      @new_issue_selection['Project name'] = project_name_input
      @new_issue_selection['Description'] = desc_input
      @new_issue_selection['Status'] = status_input
      @new_issue_selection
    end
  end
end
