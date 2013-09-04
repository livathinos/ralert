ralert
======

Ralert is a simple Ruby gem for parsing Google News search queries programmatically.


Usage
======

First, require the gem.

    require 'ralert'

or if you are using a Gemfile, append this line

    gem 'ralert'

Instantiate a SearchOptions object. This is optional and if skipped, the default options
wil be used instead.


    Options = SearchOptions.new

    options.literal = true      # Whether or not this should be a literal search, ie. BOTH keywords 
                                # need to be present in the order presented in the string.
                                # values: true, false
                                # default: false

    options.sort_by = 'd'       # Sorts by date(d) instead of relevance.
                                # values: 'd', 'r'
                                # default: 'd'

    options.date_range = 'd'    # Returns results from the specified time frame instead of 'all time'.
                                # values: 'h', 'd', 'w', 'm', 'y', 'all'
                                # default: 'w' (ie. one week)

    options.safe = 'on'         # Uses the Google safe search feature.
                                # values: on, off
                                # default: off

    options.mode = 'nws'        # Searches through the Google News module instead of the all inclusive search 
                                # module
                                # values: 'nws', 'all'
                                # default: 'nws'

Request a search with a set of keywords using the above options

    search = Ralert.new("ruby gem", options)

or request a search with the default option array

    search = Ralert.new("ruby gem")

The above will return the first 10 results from Google. In case you want more:

    search = Ralert.new("ruby gem").next_results(4)

which will return the first 4 pages of results (if available). Using a big number here might result
in performance issues.
