module Issuetracker
  class Issue
    def initialize(name = 'New Issue', category = 'Issue', content = 'Description of the issue')
      @name = name
      @category = category
      @content = content
      @hash = { 'Name' => @name, 'Category' => @category, 'Description' => @content }
    end

    attr_accessor :hash
    attr_reader :name, :category, :content

    def setname(name)
      @name = name
      @hash['Name'] = @name
    end

    def setcategory(category)
      @category = category
      @hash['Category'] = @category
    end

    def setcontent(content)
      @content = content
      @hash['Description'] = @content
    end
  end
end
