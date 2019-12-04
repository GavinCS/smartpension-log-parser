require 'terminal-table'
class PageViews
  attr_accessor :unique_views, :views, :unique_keys
  
  def initialize
    @views = {}
    @unique_views = {}  
    @unique_keys = []
  end
  
  # Add a page view for specific page
  # Defaults to views key
  # Can pass in param to switch view attribute to add to
  def add_page_view(page,param = 'views')
    key = instance_variable_get(("@" + param).intern)
    if key.key?(page)
      key[page] += 1
    else
      key[page] = 1
    end
  end  
  
  # Add unique page views to unique_views
  def add_unique_page_view(page, unique_key)
    # Check if we have already counted page view for IP
    if @unique_keys.include?(unique_key)
      return
    end

    # Add unique page view to views for specific page
    self.add_page_view(page, 'unique_views')
    # Record page / ip view calculated
    @unique_keys << unique_key
  end
  
  # Sort views desc using views count attribute
  # Return as hash
  def sort_by_views_desc(views)
    views.sort_by(&:last).reverse.to_h
  end
  
  # Print out the views data using a CLI table format
  def print_result(data, title)
    table = build_table(data,title)
    table.align_column(1, :right)
    puts "#{table} \n\n"
  end

  private
  
  def build_table(data, title) 
    Terminal::Table.new :title => title, :headings => %w(Page Visits) do |t|
      data.each do  | key, value|
        t.add_row [key, value]
      end
    end
  end
  
end