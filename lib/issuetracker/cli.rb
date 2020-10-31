require 'optparse'
require 'issuetracker/version'
module Issuetracker
  class CLI
    def initialize

      main_menu
    end

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
      main_menu_input
    end
    
    def main_menu_input
      @main_menu_input = gets.strip.downcase
      if @main_menu_input == "new" || @main_menu_input == "n"
        Project.new
      elsif @main_menu_input == "project" || @main_menu_input == "p"
        Issue.new
      elsif @main_menu_input == "archived" || @main_menu_input == "a"
        #archived_projects
        puts "Archived projects"
      else
        puts "Please make a valid entry. (New/N, Project/P, Archived/A)"
        main_menu_input
      end
    end

    
    #attr_reader :options
  end
end

