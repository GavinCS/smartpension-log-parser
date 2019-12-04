require 'page_views.rb'

RSpec.describe PageViews do
  before(:all) do
    @log_lines = [%w(home/ 127.0.0.1), %w(blog/ 127.0.0.1), %w(about/ 127.0.0.2), %w(about/ 127.0.0.3), %w(home/ 127.0.0.1), %w(home/ 127.0.0.2)]
  end
  
  before(:each) do
    @page_views = PageViews.new
  end

  it 'checks that add_page_view method exists' do
    expect(@page_views).to respond_to(:add_page_view)
  end

  it 'checks that add_unique_page_view method exists' do
    expect(@page_views).to respond_to(:add_unique_page_view)
  end

  it 'checks that sort_by_views_desc method exists' do
    expect(@page_views).to respond_to(:sort_by_views_desc)
  end

  it 'checks that print_result method exists' do
    expect(@page_views).to respond_to(:print_result)
  end

  it 'checks that add_page_view adds a view' do
    @page_views.add_page_view(@log_lines[0][0])
    expect(@page_views.views['home/']).to eq(1)
  end

  it 'checks that add_unique_page_view adds unique page views' do
    @log_lines.each  do |page, ip|
      unique_key = "#{page}-#{ip}"
      @page_views.add_unique_page_view(page, unique_key)
    end
    
    expect(@page_views.unique_views['home/']).to eq(2)
    expect(@page_views.unique_views['about/']).to eq(2)
    expect(@page_views.unique_views['blog/']).to eq(1)
  end

  it 'checks that views are sorted desc' do
    @log_lines.each  do |page, _|
      @page_views.add_page_view(page)
    end

    @page_views.views = @page_views.sort_by_views_desc(@page_views.views)
    #Test order of page/views
    expect(@page_views.views.keys[0]).to eq('home/')
    expect(@page_views.views.values[0]).to eq(3)
    
    expect(@page_views.views.keys[1]).to eq('about/')
    expect(@page_views.views.values[1]).to eq(2)
    
    expect(@page_views.views.keys[2]).to eq('blog/')
    expect(@page_views.views.values[2]).to eq(1)
  end
end
