class SexyGridSpecs < SpecController
  grid :only => [:basic, :space]
  
  def basic
    render
  end
end
