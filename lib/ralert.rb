#!/usr/bin/env ruby
#encoding: UTF-8

require 'result'
require 'search-options'

require 'rubygems'
require 'nokogiri'
require 'open-uri'

class Ralert
  attr_accessor :results, :next_page
  @page

  def initialize(query, options = nil)
    @results = Array.new

    # Take care of spaces and other special
    # characters.
    query = transform_query(query) if query.index(" ")
    
    # Instantiante a new search options object if
    # the user hasn't provided any when calling
    # the class
    options = SearchOptions.new unless !options.nil?

    uri = construct_uri(query, options)
    @results = perform_search(uri)
  end

  ##
  # Takes the query string and a SearchOptions object
  # and constructs a new search query.
  #
  def construct_uri(query, options)
    base_uri = "https://google.com/search?q="
    
    if options.literal
    	query = "%22" + query + "%22" 
    end

    if !options.date_range.nil?
      query += "&tbs=qdr:#{options.date_range}"
    else
      query += "&tbs=qdr:w"
    end

    if options.sort_by == 'd'
      query += ",sbd:1"
    end
    
    if options.safe == 'on'
      query += "&safe=on"
    else
      query += "&safe=off"
    end

    query += "&tbm=#{options.mode}"

    return base_uri + query
  end

  ##
  # Given a URI, performs a request and scans
  # the resulting page with the Nokogiri parser.
  #
  def perform_search(uri)
    html = open(uri)
    @page = Nokogiri::HTML(html.read)
    @page.encoding = 'utf-8'

    parse_results
  end
  
  ##
  # Parses the page resulting from the search query
  # and returns the search items found in a result 
  # array.
  #
  def parse_results
    cur_results = Array.new

    @page.search('li.g').each do |item|
      cur_results << node_from_item(item)
    end
    
    update_next_page unless next_page_missing
    @results += cur_results
    
    return cur_results
  end
  
  ##
  # Takes an HTML li block which represents a search 
  # result and extracts all the information from it
  # like: a title, a link, a (relative) date and the
  # articles source.
  #
  def node_from_item(item)
    result_node = Result.new
    title = '' 

    link = item.at('h3.r a')
    meta = item.search('div.slp span.f').inner_html
    
    link.children.each do |c|
      title += c
    end

    result_node.title  = title
    result_node.source = meta.split('-')[0]
    result_node.date = meta.split('-')[1]
    result_node.link = link['href'].gsub!(/\/url\?q\=/, '').gsub!(/\&sa\=.*/,'')

    return result_node
  end

  ##
  # Checks if this is the last of the search result pages
  # available.
  #
  def next_page_missing
    return @page.at_css("table#nav tr td.b:last-child").at_css("a").nil?
  end
  
  ##
  # Updates the @next_page instance variable to point
  # to the next search result page.
  #
  def update_next_page
    next_uri = @page.at_css("table#nav tr td.b:last-child").at_css("a")['href']
    @next_page = "http://www.google.com" + next_uri
  end

  ##
  # Performs the search-parse-update routine on the next 
  # page of search results if available.
  #
  def next_results(page_number = 1)
    page_number.times.each do
      !next_page_missing ? perform_search(@next_page) : break
    end

    return @results
  end

  ##
  # Takes a text query and substitutes spaces for plus signs
  # as the google search engine expects to be fed with.
  #
  def transform_query(q)
    return q.gsub!(/\s/, '+')
  end
  
  def each(&blk)
    @results.each(&blk)
  end

end
