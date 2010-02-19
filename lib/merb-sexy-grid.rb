# make sure we're running inside Merb

dir = File.dirname(__FILE__) / 'merb-sexy-grid'
require dir + '/builder'
require dir + '/grid'
require dir + '/controller/mixins/sexy_grid'

module Merb::GlobalHelpers
  include Merb::Helpers::Grid
end	

Merb::Plugins.add_rakefiles "merb-sexy-grid/merbtasks"

class Merb::AbstractController
  class_inheritable_accessor :_default_grid_builder
  include Merb::SexyGridMixin
end

Merb::BootLoader.after_app_loads do
  class Merb::AbstractController
    self._default_grid_builder =
      Object.full_const_get(Merb::Plugins.config[:helpers][:default_grid_builder]) rescue Merb::Helpers::Grid::Builder::Base
  end
end
