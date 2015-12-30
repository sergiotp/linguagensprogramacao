class RMethod
  def initialize(params, body_node)
    @params = params
    @body_node = body_node
  end

  def call(receiver, arguments)
    context = Context.new(receiver) # self = receiver
        
    @params.each_with_index do |param, index|
      context.locals[param] = arguments[index]
    end

    @body_node.eval(context)
  end
end
