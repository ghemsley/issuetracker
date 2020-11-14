require 'json'
require 'issuetracker/path'
module Issuetracker
  # This class allows converting a hash to a pretty-printed JSON format and then writing it to a file,
  # or it can read JSON from a file and convert that JSON directly to a valid ruby hash object.
  # Note that when the hash is converted to JSON, symbols get converted to strings(!).
  #
  # It requires a hash and a path as input. The hash parameter defaults to an empty hash,
  # but it should usually be called with a hash provided as an argument.
  #
  # The path defaults to a file called .issuetracker.json in the user's home directory, but this can
  # optionally be overriden to specify a custom path to read or write from.
  #
  # While the class can be instantiated with a path or not (in which case the default will be used),
  # the methods can also have that initial path be overridden by passing a new path in when the method is called.
  class FileIO
    attr_accessor :path, :mega_hash

    def initialize(path = PATH)
      self.mega_hash = {}
      self.path = path
    end

    def read_json(path = self.path)
      self.path = path
      self.mega_hash = JSON.parse(File.read(self.path)) if File.exist?(self.path)
      mega_hash
    end

    def write_json(path = self.path)
      File.open(path, 'w') do |file|
        file.write(JSON.pretty_generate(mega_hash))
      end
    end
  end
end
