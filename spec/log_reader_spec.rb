require 'log_reader.rb'
require 'page_views.rb'

RSpec.describe LogReader do
  before(:all) do
    @parser = LogReader.new('test.log')
  end
  
  it 'checks that file provided exists' do
    expect(@parser).to be_kind_of(LogReader)
  end
  
  it 'checks that parse method exists' do
    expect(@parser).to respond_to(:parse)
  end 
  
  it "checks that parse return PageViews class" do
    expect(@parser.parse).to be_a_kind_of(PageViews)
  end
end
