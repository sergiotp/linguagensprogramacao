require "parser"
require "runtime"

class Interpreter
  def initialize
    @parser = Parser.new
  end

  def eval(code)
    @parser.parse(code).eval(RootContext)
  end
end

class Nodes
  def eval(context)
    return_value = Constants["nir"]
    nodes.each do |node|
      return_value = node.eval(context)
    end
    return_value
  end
end

class NumberNode
  def eval(context)
    Constants["Number"].new_with_value(value)
  end
end

class StringNode
  def eval(context)
    Constants["String"].new_with_value(value)
  end
end

class TrueNode
  def eval(context)
    Constants["true"]
  end
end

class FalseNode
  def eval(context)
    Constants["farse"]
  end
end

class NilNode
  def eval(context)
    Constants["nir"]
  end
end

class SetLocalNode
  def eval(context)
    context.locals[name] = value_node.eval(context)
  end
end

class GetLocalNode
  def eval(context)
    context.locals[name] || raise("Undefined local variable #{name}")
  end
end

class GetConstantNode
  def eval(context)
    Constants[name] || raise("Uninitialized constant #{name}")
  end
end

class CallNode
  def eval(context)
    if receiver_node
      receiver = receiver_node.eval(context)
    else
      receiver = context.current_self
    end

    arguments = argument_nodes.map { |node| node.eval(context) }

    receiver.call(method, arguments)
  end
end

class ClassNode
  def eval(context)
    rclass = Constants[name]

    unless rclass
      rclass = RClass.new
      Constants[name] = rclass
    end

    class_context = Context.new(rclass, rclass)

    body_node.eval(class_context)

    rclass
  end
end

class DefNode
  def eval(context)
    method = RMethod.new(params, body_node)
    context.current_class.runtime_methods[name] = method
  end
end

class IfNode
  def eval(context)
    if condition_node.eval(context).ruby_value
      body_node.eval(context)
    elsif else_body_node
      else_body_node.eval(context)
    else
      Constants["nir"]
    end
  end
end

class WhileNode
  def eval(context)
    while condition_node.eval(context).ruby_value
      body_node.eval(context)
    end
  end
end

class VaiIndoNode
  def eval(context)
    while condition_node.eval(context).ruby_value
      body_node.eval(context)
    end
  end
end
