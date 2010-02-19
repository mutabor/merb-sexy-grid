class FakeModel
  
  attr_accessor :vin, :make, :model
  
  def self.columns
    [FakeColumn.new(:foo, :string), 
     FakeColumn.new(:foobar, :string)
     ]     
  end

	def self.all
		res = Array.new
		(1..5).each do |i|
			res << FakeModel.new(:id => i, :name => "name #{i}")
		end
		res
	end

	def [](index)
    @data[index]
  end

  def valid?
    false
  end
  
  def new_record?
    false
  end

  def initialize(data = {})
    @data = data
  end
  
  def to_s
    'fake_model'
  end
end
