class RClass < RObject
  attr_reader :runtime_methods

  def initialize
    @runtime_methods = {}
    @runtime_class = Constants["Class"]
    @basic_object = Constants["Object"]
  end

  def lookup(method_name)
    if @runtime_methods[method_name]
      @runtime_methods[method_name]
    elsif @basic_object.runtime_methods[method_name]
      @basic_object.runtime_methods[method_name]
    else
      raise("Undefined method #{method_name}")
    end
  end

  def def(name, &block)
    @runtime_methods[name.to_s] = block
  end

  def new
    RObject.new(self)
  end

  def new_with_value(value)
    RObject.new(self, value)
  end
end
