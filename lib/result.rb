class Result 
  attr_accessor :link, :title, :source, :date
  
  def initialize(link='', title='', source = '', date = '')
	  @link = link
	  @title = title
	  @source = source
	  @date = date
  end

  def ==(other)
    self.class === other and
    other.author == @link and
    other.title == @title and 
    other.source = @source and 
    other.date == @date
  end

  alias eql? ==
  def hash
    @link.hash ^ @title.hash ^ @source.hash ^ @date.hash # XOR
  end
end
