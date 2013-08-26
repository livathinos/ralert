ralert
======

Ralert is a simple Ruby gem for parsing Google News search queries programmatically.


Usage
======

First, require the gem.

    require 'ralert'

Instantiate a SearchOptions object. This is optional and if skipped, the default options
wil be used instead.

    options = SearchOptions.new
    options.literal = true
    options.sort_by = 'd'    # sorts by date instead of relevance (default).
    options.date_range = 'd' # keeps results from the last 24 hours instead of 'all time' (default)
    options.safe = 'on'      # uses safe search
    options.mode = 'nws'     # searches Google News

Request a search with a set of keywords using the above options

    search = Ralert.new("ruby gem", options)

or request a search with the default option array

    search = Ralert.new("ruby gem")

The above will return the first 10 results from Google. In case you want more:

    search = Ralert.new("ruby gem").next_results(4)

which will return the first 4 pages of results (if available). Using a big number here might result
in performance issues.
