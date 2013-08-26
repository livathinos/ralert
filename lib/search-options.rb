class SearchOptions
  attr_accessor :literal, :sort_by, :date_range, :safe, :mode

  def initialize(literal = nil, sort_by = nil, date_range = nil, safe = nil, mode = nil)
    @literal = literal
    @sort_by = sort_by
    @date_range = date_range
    @safe = safe
    @mode = mode
  end

end
