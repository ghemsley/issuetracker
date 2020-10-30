require 'issuetracker/version'
require 'issuetracker/cli'
require 'issuetracker/issue'
require 'issuetracker/fileio'
require 'issuetracker/project'
module Issuetracker
  class Error < StandardError; end
 # I moved around and modified the code you had in bin/issuetracker, because that file
 # is just meant for making the program properly accessible via the shell. What you had
 # makes more sense to put in here, and to keep the 'best practices' structure we should
 # not modify bin/issuetracker much most likely, instead, program flow can be defined here
 # and specific subroutines or constants can be defined in classes or methods in the files in lib/issuetracker.
  cli = CLI.new
  cli.main_menu
  
end
