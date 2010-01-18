module Merb::Helpers::Grid

  def _singleton_grid_context
    self._default_grid_builder = Merb::Helpers::Grid::Builder::Base unless self._default_grid_builder
    @_singleton_grid_context ||=
      self._default_grid_builder.new(nil, nil, self)
  end

  def grid_contexts
    @_grid_contexts ||= []
  end

  def current_grid_context
    grid_contexts.last || _singleton_grid_context
  end

  def _new_grid_context(name, builder)
    if name.is_a?(String) || name.is_a?(Symbol)
      ivar = instance_variable_get("@#{name}")
    else
      ivar, name = name, name.class.to_s.snake_case
    end
    builder ||= current_grid_context.class if current_grid_context
    (builder || self._default_grid_builder).new(ivar, name, self)
  end

  def with_grid_context(name, builder)
    grid_contexts.push(_new_grid_context(name, builder))
    ret = yield
    grid_contexts.pop
    ret
  end

# ------------
  def grid_for(name, attrs = {}, &blk)
    with_grid_context(name, attrs.delete(:builder)) do
      current_grid_context.grid(attrs, &blk)
    end
  end

# -----------
	def column(title, name, attrs ={}, &blk)
		current_grid_context.column(title, name, attrs, &blk)
	end
end

