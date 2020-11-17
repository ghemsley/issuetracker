require 'json'
require 'issuetracker/path'
module Issuetracker
  # This class allows converting a hash to a pretty-printed JSON format and then writing it to a file,
  # or it can read JSON from a file and convert that JSON directly to a valid ruby hash object.
  # Note that when the hash is converted to JSON, symbols get converted to strings(!)
  #
  # It can accept a path as input. If none is provided a default will be used.
  #
  # The path defaults to a file called .issuetracker.json in the user's home directory, but this can
  # optionally be overriden to specify a custom path to read or write from.
  #
  # While the class can be instantiated with a path or not,
  # the methods can also have that initial path be overridden by passing a new path in when the method is called.
  class FileIO
    attr_accessor :path, :mega_hash

    # Path is optional and defaults to a path constant defined in path.rb
    def initialize(path = PATH)
      self.mega_hash = {}
      self.path = path
    end

    # Reads JSON from file at path and convert to mega hash, return mega hash
    def read_json(path = self.path)
      self.path = path
      self.mega_hash = JSON.parse(File.read(self.path)) if File.exist?(self.path)
      mega_hash
    end

    # Converts megahash to JSON and writes to file at path
    def write_json(path = self.path)
      File.open(path, 'w') do |file|
        file.write(JSON.pretty_generate(mega_hash))
      end
    end
  end
end
