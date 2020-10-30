require 'json'
module Issuetracker
  class FileIO
    def initialize(hash = {}, path = './.issuetracker')
      @hash = hash
      @path = path
    end

    attr_accessor :path, :hash

    def readJSON(path = @path)
      @path = path
      @hash = JSON.parse(File.read(@path)) if File.exist?(@path)
      @hash
    end

    def writeJSON(path = @path)
      File.open(path, 'w') do |file|
        file.write(JSON.pretty_generate(@hash))
      end
    end
  end
end
