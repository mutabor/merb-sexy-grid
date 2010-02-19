module Merb
	module SexyGridMixin
		# ==== Parameters
	  # base<Module>:: Module that is including SexyGridMixin (probably a controller)
		#
	  # @private
	  def self.included(base)
		  base.extend(ClassMethods)
	    base.class_eval do			  
		  end
	  end
	
    module ClassMethods
			def grid(params)
#				self.before(nil, params) do
#					p "---------- YAHOOO2 ------------"
#				end
#				p params
#				p "---------- YAHOOO ------------"
			end
		end
	end
end
