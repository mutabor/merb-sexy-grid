require 'logger'
require File.dirname(__FILE__) + '/spec_helper'

describe "sexy_grid" do

  before :each do
    @c = SexyGridSpecs.new(Merb::Request.new({}))
    @c.instance_variable_set(:@obj, FakeModel.all)	
  end

  it "should render basic table" do
    ret = @c.render(:basic)
#    ret = @c.basic
    ret.should have_selector("table")
		File.open('spec/logs/basic.html', 'w+'){|f| f.puts(ret)}
  end
end


