require "rubygems"
require "spec"
require "merb-core"
require 'merb-helpers'
require File.join(File.dirname(__FILE__),"..",'lib',"merb-sexy-grid")
require "date"
require "webrat"

default_options = {
  :environment => 'test',
  :adapter     => 'runner',
  :merb_root   => File.dirname(__FILE__) / 'fixture',
  :log_file    => File.dirname(__FILE__) / "merb_test.log"
}
options = default_options.merge($START_OPTIONS || {})

Merb.disable(:initfile)
Merb.start_environment(options)

def unload_merb_helpers
  Merb.class_eval do
    remove_const("Helpers") if defined?(Merb::Helpers)
  end
end

def reload_merb_helpers
  unload_merb_helpers
  load(MERB_HELPERS_ROOT + "/lib/merb-helpers.rb")
  Merb::Helpers.load
end

class FakeColumn
  attr_accessor :name, :type

  def initialize(name, type)
    @name, @type = name, type
  end

end

Spec::Runner.configure do |config|
#  config.include Merb::Test::Helper
#  config.include Merb::Test::RspecMatchers
#  config.include Merb::Test::RequestHelper
  config.include Webrat::Matchers
  config.include Webrat::HaveTagMatcher

  def with_level(level)
    Merb.logger = Merb::Logger.new(StringIO.new, level)
    yield
    Merb.logger
  end
end
