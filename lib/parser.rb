#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'
require_relative 'log_reader'
require_relative 'page_views'

class Parser
  include Commander::Methods
  
  def run
    program :name, 'parser'
    program :version, '0.0.1'
    program :description, 'Parse log file and sort page views desc'
    
    command :print_page_views do |c|
      c.syntax = 'parser print_page_views --filename=logfile.log'
      c.description = 'Prints ordered page views and unique page views in descending order'
      c.option '--filename STRING', String, 'Some switch that does something'
      c.action do |_, options|
        reader = LogReader.new(options.filename)
        page_views = reader.parse
        self.print_results(page_views)
      end
    end  
  end
  
  def print_results(page_views)
    unless page_views.is_a?(PageViews)
      raise Exception.new "Expected Class PageViews, got: #{page_views.class.name}"
    end
    unless page_views.views.empty?
      page_views.print_result(page_views.views, "Page views")
    end

    unless page_views.views.empty?
      page_views.print_result(page_views.unique_views, "Unique page views")
    end
  end
  
end

Parser.new.run if $0 == __FILE__
