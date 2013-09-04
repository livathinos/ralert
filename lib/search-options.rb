class SearchOptions
  attr_accessor :literal, :sort_by, :date_range, :safe, :mode

  def initialize(literal = false, sort_by = 'd', date_range = 'w', safe = 'off', mode = 'nws')
    @literal = literal
    @sort_by = sort_by
    @date_range = date_range
    @safe = safe
    @mode = mode
  end

end
