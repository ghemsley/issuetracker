require 'json'
require 'issuetracker/path'
module Issuetracker
  class FileIO
    # This class allows converting a hash to a pretty-printed JSON format and then writing it to a file,
    # or it can read JSON from a file and convert that JSON directly to a valid ruby hash object.
    # It requires a hash and a path as input. The hash parameter defaults to an empty hash,
    # but it should usually be called with a hash provided as an argument.
    # The path defaults to a file called .issuetracker in the user's home directory, but this can
    # optionally be overriden to specify a custom path to read or write from.
    # While the class can be instantiated with a path or not (in which case the default will be used),
    # the methods can have that initial path be overridden by passing a new path in when the method is called.
    def initialize(path = PATH)
      @hash = {}
      @path = path
    end

    attr_accessor :path, :hash

    def read_json(path = @path)
      @path = path
      @hash = JSON.parse(File.read(@path)) if File.exist?(@path)
      @hash
    end

    def write_json(path = @path)
      File.open(path, 'w') do |file|
        file.write(JSON.pretty_generate(@hash))
      end
    end
  end
end
