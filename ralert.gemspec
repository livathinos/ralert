Gem::Specification.new do |s|
    s.name	     = 'ralert'
    s.version	   = '0.3.0'
    s.date	     = '2013-09-04'
    s.summary	   = 'Ralert is a simple Ruby gem for parsing Google News search queries programmatically.'
    s.description= 'Queries the Google search engine and returns an array of Result objects.'
    s.authors	   = ["Spyros Livathinos"]
    s.email	     = 'livathinos.spyros@gmail.com'
    s.files	     = ["lib/ralert.rb", 
	                  "lib/result.rb",
    		            "lib/search-options.rb"]
    s.homepage	 = 'http://github.com/livathinos/ralert'
    s.license	   = "MIT"
end
