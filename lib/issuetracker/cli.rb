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
        new_issue
      elsif @main_menu_input == "project" || @main_menu_input == "p"
        current_projects
      elsif @main_menu_input == "archived" || @main_menu_input == "a"
        archived_projects
      else
        puts "Please make a valid entry. (New/N, Project/P, Archived/A)"
        main_menu_input
      end
    end

    def new_issue
      #temp vars to let code work
      @issuenumber = 1
      @projectname = "Very Important Project"
      @issuedescription = "A very important description"
      @status = "open"

      # Hey @jessijoke - I think we might be duplicating some effort above?
      # Check out the code in issue.rb and see if maybe it does some of what you are looking for?
      # You can create a new issue instance with default values by requiring 'issuetracker/issue'
      # at the top of this file and assigning Issue.new to a variable.
      # Check out its methods, they each let you set an issue property and update the issue hash automatically.
      # Let me know if you see any problems with this?
      # ^ from @ghemsley ^

      puts "you made a bug hahaha"
      create_new_issue_1
      def create_new_issue_1
        #Get issue # from json, issue # is number of bugs + 1
        puts "
╔═══════════════════╗
  Issue: #{@issuenumber} 
╚═══════════════════╝
Input a name for your project or input -p or -projects to view current projects:
"
        create_new_issue_2
      end
      def create_new_issue_2
        print "Project Name: " + @projectname = gets.strip
        # if @projectname.includes? bad characters we don't allow in project names like ?><~!@#$%^&^* -- return an error telling them to name the project without special characters and then call create_new_issue_2 again

        # if json.includes?(@projectname) -- I don't know this code but it would go into the hash with that project's files

        # else

        # create a new hash for this project and add it to the new hash

        # Hey @jessijoke - I tried to write something that might be suitable for that last comment in a new Project class.
        # Check out project.rb and let me know if you have questions or concerns?
        # ^ from @ghemsley ^

        create_new_issue_3
      end
        puts "
╔═══════════════════╗
  Issue: #{@issuenumber} 
╚═══════════════════╝
Project: #{@projectname}
Input a description for your project issue:
"
        puts "
╔═══════════════════╗
  Issue: #{@issuenumber} 
╚═══════════════════╝
Project: #{@projectname}
Description: #{@issuedescription}
Input a status for your issue (Active/Solved/Wont Solve): 
"
      puts "
╔═══════════════════╗
  Issue: #{@issuenumber} 
╚═══════════════════╝
Project: #{@projectname}
Description: #{@issuedescription}
Status: #{@status}

┌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┐ ┌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┐ ┌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┐ ┌╌╌╌╌╌╌╌╌╌╌┐
    Edit Project      Edit Description       Edit Status         Delete
    Project or P      Description or D       Status or S          Del
└╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┘ └╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┘ └╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┘ └╌╌╌╌╌╌╌╌╌╌┘
"
      puts "
╔═══════════════════╗
      !WARNING!
╚═══════════════════╝
Are you sure you want to delete Issue #{@issuenumber}? This change is permanent and cannot be undone. (y/n)
"
    end

    def current_projects
      puts "This is all the projects"
    end

    def archived_projects
      puts "Welcome to warehouse 13"
    end
    #attr_reader :options
  end
end
