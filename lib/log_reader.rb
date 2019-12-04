require_relative 'page_views'

class LogReader
  def initialize(file)
    if File.file?("#{file}")
      @file_name = file
    else
      raise "File does not exist"  
    end
  end
  
  def parse
    # Read file and calculate total page view / unique page views
    page_views = calculate_views_from_file
    
    # Sort Page views
    page_views.views = page_views.sort_by_views_desc(page_views.views)
    page_views.unique_views = page_views.sort_by_views_desc(page_views.unique_views)
    
    # Return PageViews class with sorted views
    page_views
  end

  private
  
  def calculate_views_from_file
    page_views = PageViews.new
    
    File.readlines(@file_name).sort.each do |line|
      begin
        # Split line to get page / ip
        line_values = line.split(" ")
        # Handle malformed line
        if line_values[1].nil?
          raise "invalid line, missing ip. continuing..."
        end
        
        page = line_values[0]
        ip = line_values[1]

        # Add page view  to views for specific page
        page_views.add_page_view(page)

        # Create unique page / IP key to determine unique page vies
        unique_key = "#{page}-#{ip}"
        # Add unique page view to views for specific page
        page_views.add_unique_page_view(page, unique_key)
        
      rescue StandardError => e
        puts e
      end
    end
    
    # Return PageViews object
    page_views
  end
end

