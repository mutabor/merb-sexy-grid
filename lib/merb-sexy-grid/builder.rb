module Merb::Helpers::Grid
  module Builder

		class GridColumn
			attr_reader :attrs 

			def initialize(title, name, attrs)				
				@title, @name, @attrs = title, name, attrs
			end

			def format(row)
				@name.is_a?(Proc) ? @name.call(row) : row[@name]
			end
		end

    class Base 
	    include Merb::Helpers::Tag

		  def initialize(obj, name, origin)
			  @obj, @origin = obj, origin
				@name = name || @obj.class.name.snake_case.split("/").last
				@columns = []
	    end

	    def grid(attrs = {}, &blk)
				header = tag(:thead, tag(:tr, @origin.capture(&blk))).gsub(/\n/, '').gsub(/\>\s+\</, '><')
				content = ""
					@obj.each do |row|	
						row_content = ""
						@columns.each do |col|
							row_content = row_content + tag(:td, col.format(row), col.attrs)
						end
						content = content + tag(:tr, row_content, :class => ('even' if (row[:id]%2 == 0)))
					end	
				tag(:table, tag(:tbody, header + content), attrs)
			end

			def column(title, name, attrs = {}, &blk)
				unless block_given? 
					captured = title
				else
					captured = @origin.capture(&blk)
				end
				@columns << GridColumn.new(captured, name, attrs)
		    tag(:th, captured, attrs)
	    end

    end
  end
end
