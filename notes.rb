puts "
   __   __        ___    ___  __        __        ___  __  
| /__` /__` |  | |__      |  |__)  /\  /  ` |__/ |__  |__) 
| .__/ .__/ \__/ |___     |  |  \ /~~\ \__, |  \ |___ |  \ 
                                                           
"
puts "
    ____                        ______                __            
   /  _/___________  _____     /_  __/________ ______/ /_____  _____
   / // ___/ ___/ / / / _ \     / / / ___/ __ `/ ___/ //_/ _ \/ ___/
 _/ /(__  |__  ) /_/ /  __/    / / / /  / /_/ / /__/ ,< /  __/ /    
/___/____/____/\__,_/\___/    /_/ /_/   \__,_/\___/_/|_|\___/_/     
                                                                    
"



#===============================================
#Issue Tracker Title
#===============================================
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

#===============================================
#New Issue Map
#===============================================
puts "
╔═══════════════════╗
  Issue: #{@issuenumber} 
╚═══════════════════╝
Input a name for your project or input -p or -projects to view current projects:
"
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
#===============================================
#Current Issue Map
#===============================================


=begin 
New Issue (New or N)
  (Will Automatically Generator an issue number/index)
  Prompt asking for Project Name/View Current Projects
    View current Projects
  Issue Description
  Status (Active/Solved/Won't Solve)
  Go to bug after created
    Change Status/Change Description/Change Project/Delete

Current Issues (Current or C)
  View by Projects (Project or P)
    Select Issue
      Change Status/Change Description/Change Project/Delete
  View by Issue Number (Issue or I)
    Select Issue
      Change Status/Change Description/Change Project/Delete
  View by Status (Satus or S)
    Select Issue
      Change Status/Change Description/Change Project/Delete
  View all Active Issues (All or A)



Archived Issues (Archived or A)
  View by Projects (Project or P)
    Select Issue
      Change Status/Change Description/Change Project/Delete
  View by Issue Number (Issue or I)
    Select Issue
      Change Status/Change Description/Change Project/Delete
  View by Status (Status or S)
    Select Issue
      Change Status/Change Description/Change Project/Delete
=end